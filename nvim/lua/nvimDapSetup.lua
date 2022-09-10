local U = require("utilities")
local au = require("au")
local Job = require("plenary.job")

local M = {
	cDAPConfig = {
		{
			type = "codelldb",
			request = "launch",
			name = "Debug Executable - " .. vim.loop.cwd() .. "/main",
			program = "${workspaceFolder}/main",
			cwd = "${workspaceFolder}",
		},
		{
			type = "codelldb",
			request = "launch",
			name = "Debug Executable - Choose",
			cwd = "${workspaceFolder}",
			program = function()
				return "${workspaceFolder}/" .. vim.fn.input(vim.loop.cwd() .. "/")
			end,
		},
	},
}

---@param table table
---@param value table
---@return boolean
local function hasValue(table, value)
	for _, tableValue in ipairs(table) do
		if tableValue == value then
			return true
		end
	end

	return false
end

-- table.filter({"a", "b", "c", "d"}, function(o, k, i) return o >= "c" end)  --> {"c","d"}
--
-- @FGRibreau - Francois-Guillaume Ribreau
-- @Redsmin - A full-feature client for Redis http://redsmin.com
table.filter = function(t, filterIter)
	local out = {}

	for k, v in pairs(t) do
		if filterIter(v, k, t) then
			table.insert(out, v)
		end
	end

	return out
end

--- From http://lua-users.org/wiki/StringRecipes
local function endsWith(str, ending)
	return ending == "" or str:sub(-#ending) == ending
end

--- Runs `cargo and returns its output in chunks.
--- @param args table
--- @return table | nil
function M.runCargo(args)
	U.runProgramChunked("cargo", args)
end

--- Runs `cargo` with `args` and retrieves its compilation artifacts.
--- @param args table
--- @return table: An array of artifacts.
function M.getCargoArtifacts(args)
	local rapidjson = require("rapidjson")
	local artifacts = {}
	local res = M.runCargo(args)

	for _, data in ipairs(res) do
		local succeded, tbl = pcall(rapidjson.decode, data)

		if succeded and tbl ~= nil then
			if tbl.reason == "compiler-artifact" then
				local isBinary = hasValue(tbl.target.crate_types, "bin")
				local isBuildScript = hasValue(tbl.target.kind, "bin")

				if (isBinary and not isBuildScript) or tbl.profile.test then
					if tbl.executable ~= nil then
						table.insert(artifacts, {
							fileName = tbl.executable,
							name = tbl.target.name,
							kind = tbl.target.kind[1],
						})
					else -- Older Cargo
						for index, value in ipairs(tbl.filenames) do
							if endsWith(value, ".dSYM") then
								table.insert(artifacts, {
									fileName = value,
									name = tbl.target.name,
									kind = tbl.target.kind[index],
								})
							end
						end
					end
				end
			end
		end
	end

	return artifacts
end

--- Finds the full path to a program for a executable/libaray/test from the `arg`s and the `filter` in `cargoConfig`.
--- @param cargoConfig table
--- @return string | nil
---
--- `cargoConfig` table:
--- ```lua
--- {
---		args: string | nil,
---		filter: {
---			name: string | nil,
--			kind: string | nil
---		} | nil
---	}
-- ```
function M.getProgramFromCargoConfig(cargoConfig)
	local args = cargoConfig.args
	table.insert(args, "--message-format=json")
	local artifacts = M.getCargoArtifacts(args)

	if cargoConfig.filter ~= nil then
		artifacts = table.filter(artifacts, function(value, key, index)
			if cargoConfig.filter.name ~= nil and value.name ~= cargoConfig.filter.name then
				return false
			else
				if cargoConfig.filter.kind ~= nil and value.kind ~= cargoConfig.filter.kind then
					return false
				end

				return true
			end
		end)
	end

	if #artifacts == 0 then
		vim.notify(
			"Cargo has produced no matching compilation artifacts: " .. vim.inspect(cargoConfig),
			"warning",
			{ title = "DAP Configuration Generator - Rust" }
		)
		return nil
	else
		if #artifacts > 1 then
			vim.notify(
				"Cargo has produced more than one matching compilation artifact: " .. vim.inspect(cargoConfig),
				"warning",
				{ title = "DAP Configuration Generator - Rust" }
			)
			return nil
		end
	end

	return artifacts[1].fileName
end

function M.dapConfigFromRustCrate()
	if vim.loop.fs_access(vim.loop.cwd() .. "/Cargo.toml", "r") then
		local res = M.runCargo({ "metadata", "--no-deps", "--format-version=1" })

		local dap = require("dap")
		local rapidjson = require("rapidjson")

		if res == nil or #res == 0 then
			return nil
		end

		local succeded, tbl = pcall(rapidjson.decode, res[1])
		local configArray = {}

		if succeded and tbl ~= nil then
			for _, package in ipairs(tbl.packages) do
				--- @param name string The name of this configuration
				--- @param program string The program to debug
				local function addConfig(name, program)
					table.insert(configArray, {
						type = "codelldb",
						request = "launch",
						name = name,
						cwd = "${workspaceFolder}",
						args = {},
						program = program,
					})
				end

				for _, target in ipairs(package.targets) do
					local libAdded = false

					for _, kind in ipairs(target.kind) do
						if hasValue({ "lib", "rlib", "staticlib", "dylib", "cstaticlib" }, kind) then
							if not libAdded then
								local program = M.getProgramFromCargoConfig({
									args = { "test", "--no-run", "--lib", "--package=" .. package.name },
									filter = { name = target.name, kind = "lib" },
								})

								if program ~= nil then
									addConfig("Debug unit tests in library '" .. target.name .. "'", program)
									libAdded = true
								end

								break
							end
						elseif hasValue({ "bin", "example" }, kind) then
							local prettyKind = (kind == "bin") and "executable" or kind

							local program = M.getProgramFromCargoConfig({
								args = { "build", "--" .. kind .. "=" .. target.name, "--package=" .. package.name },
								filter = { name = target.name, kind = kind },
							})

							if program ~= nil then
								addConfig("Debug " .. prettyKind .. " '" .. target.name .. "'", program)
							end

							local program1 = M.getProgramFromCargoConfig({
								args = {
									"test",
									"--no-run",
									"--" .. kind .. "=" .. target.name,
									"--package=" .. package.name,
								},
								filter = { name = target.name, kind = kind },
							})

							if program1 ~= nil then
								addConfig("Debug unit tests in " .. prettyKind .. " '" .. target.name .. "'", program)
							end

							break
						elseif hasValue({ "bench", "test" }, kind) then
							local prettyKind = (kind == "bench") and "benchmark"
								or (kind == "test") and "integration test"
								or kind

							local program = M.getProgramFromCargoConfig({
								args = {
									"test",
									"--no-run",
									"--" .. kind .. "=" .. target.name,
									"--package=" .. package.name,
								},
								filter = { name = target.name, kind = kind },
							})

							if program ~= nil then
								addConfig("Debug " .. prettyKind .. " '" .. target.name .. "'", program)
							end

							break
						end
					end
				end
			end
		end

		return configArray
	end
end

-- Gets information about debuggable executables from `swift package`, and uses that to generate a `nvim-dap` configuration.
function M.dapConfigFromSwiftPackage()
	if vim.loop.fs_access(vim.loop.cwd() .. "/Package.swift", "r") then
		local rapidjson = require("rapidjson")
		local data = U.runProgram("swift", { "package", "describe", "--type", "json" })

		local succeded, tbl = pcall(rapidjson.decode, data)

		local configArray = {}
		local libLLDB = require("settings").libLLDB

		-- TODO: Generate config for tests.

		if succeded and tbl ~= nil then
			-- Check for executables
			for _, value in pairs(tbl.products) do
				if value.type.executable ~= nil then
					table.insert(configArray, {
						type = "codelldb",
						request = "launch",
						name = value.name .. " - Debug Executable (in Target " .. value.targets[1] .. ")",
						program = "${workspaceFolder}/.build/debug/" .. value.name,
						cwd = "${workspaceFolder}",
						liblldb = libLLDB,
					})

					table.insert(configArray, {
						type = "codelldb",
						request = "launch",
						name = value.name .. " - Debug Executable (Release) (in Target " .. value.targets[1] .. ")",
						program = "${workspaceFolder}/.build/release/" .. value.name,
						cwd = "${workspaceFolder}",
						liblldb = libLLDB,
					})
				end
			end

			-- Check for test targets
			for _, value in pairs(tbl.targets) do
				if value.type == "test" then
					local program = "${workspaceFolder}/.build/debug/" .. value.name .. ".xctest"
					local args = {}

					if jit.os == "OSX" then
						program = "/Applications/Xcode.app/Contents/Developer/usr/bin/xctest"
						args = { "${workspaceFolder}/.build/debug/" .. value.name .. ".xctest" }
					end

					table.insert(configArray, {
						type = "codelldb",
						request = "launch",
						name = "Debug Tests - " .. value.name,
						program = program,
						args = args,
						cwd = "${workspaceFolder}",
						liblldb = libLLDB,
					})
				end
			end
		else
			vim.notify(
				"Error in `swift package describe --json` JSON:\n\n" .. (tbl or "Missing JSON!"),
				"error",
				{ title = "DAP Configuration Generator - Swift" }
			)
		end

		return configArray
	end
end

--- Generate a TOML configuration file for `lang`.
--- @param langs table The languages to generate the configuration for.
function M.genConfig(langs)
	local toml = require("toml")

	local table = {}

	for _, lang in ipairs(langs) do
		if lang == "swift" then
			local swiftConfig = M.dapConfigFromSwiftPackage()

			if swiftConfig ~= nil then
				table["swift"] = swiftConfig
			end
		elseif lang == "rust" then
			local rustConfig = M.dapConfigFromRustCrate()

			if rustConfig ~= nil then
				table["rust"] = rustConfig
			end
		elseif lang == "c" then
			table["c"] = M.cDAPConfig
		elseif hasValue({ "c++", "cpp" }, lang) then
			table["cpp"] = M.cDAPConfig
		end
	end

	--local fd = vim.loop.fs_open(path, "r", 438)

	local fh = io.open(vim.loop.cwd() .. "/" .. U.nvimDapTOML, "w+")
	if fh:seek("end") ~= 0 then
		local originalData = toml.decode(fh:read("*all"))

		for key, value in pairs(originalData) do
			if table[key] == nil then
				table[key] = value
			else
				-- Complicated work...
			end
		end
	end

	fh:seek("set")
	fh:write(toml.encode(table))
	fh:close()
end

--- Loads a debugging configuration from a `.nvim-dap.toml` file.
--- @param silent boolean: Whether this function should display a warning if the `.nvim-dap.toml` file is not found.
function M.loadConfig(silent)
	local toml = require("toml")
	local dap = require("dap")

	local file = vim.loop.cwd() .. "/" .. U.nvimDapTOML

	if not vim.loop.fs_access(file, "r") then
		if not silent then
			vim.notify(
				"`" .. U.nvimDapTOML .. "` does not exist! You should first generate the file using `:GenConfig`.",
				"error",
				{ title = "DAP Loader" }
			)
		end

		return nil
	end

	local fh = io.open(file)
	local data = fh:read("*all")
	fh:close()

	for key, value in pairs(toml.decode(data)) do
		dap.configurations[key] = value
	end
end

--- Inserts `config` (from .`nvim-dap.toml`) into `dap.configurations`.
--- @param config string
function M.addConfigToNvimDap(config)
	local dap = require("nvim-dap")
end

function M.nvimDapSetup()
	local dap = require("dap")
	dap.set_log_level("TRACE")

	U.autocmd("FileType", {
		pattern = "dap-repl",
		callback = function()
			require("dap.ext.autocompl").attach()
		end,
	})

	-- Mappings & Commands

	U.userCmd("GenConfig", function(opts)
		for s in opts.args:gmatch("%S+") do
			M.genConfig({ s })
		end
	end, {
		nargs = "+",
		desc = "Generate a debug configuration.",
		complete = function(ArgLead, CmdLine, CursorPos)
			return { "Swift", "C", "C++", "Rust" }
		end,
	})

	U.userCmd("LoadConfig", function(opts)
		M.loadConfig(false)
	end, {
		desc = "Load a debug config from a `nvim-dap.toml` file in the current directory.",
	})

	U.map("n", "<F5>", function()
		dap.continue()
	end, { silent = true })

	U.map("n", "<leader>dd", function()
		dap.disconnect()
		dap.close()
		require("dapui").close()
	end, { silent = true })

	U.map("n", "<F8>", function()
		vim.ui.input({ prompt = "Breakpoint Condition: " }, function(input)
			dap.set_breakpoint(input)
		end)
	end, { silent = true })

	U.map("n", "<F9>", function()
		dap.toggle_breakpoint()
	end, { silent = true })

	U.map("n", "<F10>", function()
		dap.step_over()
	end, { silent = true })

	U.map("n", "<F11>", function()
		dap.step_into()
	end, { silent = true })

	U.map("n", "<F12>", function()
		dap.step_out()
	end, { silent = true })

	-- Debuggers
	dap.adapters.codelldb = {
		type = "server",
		port = "1234",
		executable = {
			command = "codelldb",
			args = { "--port", "1234" },

			-- On windows you may have to uncomment this:
			-- detached = false,
		},
	}

	dap.configurations.c = M.cDAPConfig
	dap.configurations.cpp = M.cDAPConfig

	M.loadConfig(true)
end

return M
