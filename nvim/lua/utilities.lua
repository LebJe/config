--- Utilites
local U = {

	--- Name of the configuration file for debugging.
	nvimDapTOML = ".nvim-dap.toml",

	--- Shorter name for `vim.keymap.set`
	--- @type function
	map = vim.keymap.set,

	--- Shorter name for `vim.api.nvim_create_autocmd`
	--- @type function
	autocmd = vim.api.nvim_create_autocmd,

	--- Shorter name for `vim.api.nvim_create_user_command`
	--- @type function
	userCmd = vim.api.nvim_create_user_command,
}

--- Runs `program` syncronously and returns its output.
--- @param program string
--- @param args table
--- @return table | nil
function U.runProgram(program, args)
	local Job = require("plenary.job")
	local res = ""
	-- TODO: Better error handling.

	Job:new({
		command = program,
		args = args,
		cwd = vim.loop.cwd(),
		on_stdout = function(_, data)
			res = res .. data
		end,
	}):sync()

	return res
end

--- Runs `program` syncronously and returns its output in chunks.
--- @param program string
--- @param args table
--- @return table | nil
function U.runProgramChunked(program, args)
	local Job = require("plenary.job")
	-- TODO: Better error handling.
	local res = {}

	Job:new({
		command = program,
		args = args,
		cwd = vim.loop.cwd(),
		on_stdout = function(_, data)
			--print("Stdout recieved: " .. data)
			table.insert(res, data)
		end,
	}):sync(5000)

	return res
end

return U
