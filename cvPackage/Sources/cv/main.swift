import ArgumentParser

struct Main: ParsableCommand {
	static var configuration: CommandConfiguration = CommandConfiguration(
		commandName: "cv",
		abstract: "Generates configuration files for Vimspector.",
		version: "0.0.1",
		subcommands: [ConfigCommand.self, GenerateCommand.self],
		defaultSubcommand: GenerateCommand.self
	)
}

Main.main()
