module Gringott

  # Here all the commands are defined as a command class
  module Commands

    # Base class for all commands, a command class responds to an exec method
    class Command

      def initialize(args)
        @args = args
      end

      def exec
        puts "Error: Bad command, type `help` to get a list of supported commands"
      end
    end

    # Vault - create, drop and list
    class Create < Command; end
    class Drop < Command; end
    class List < Command; end
    class Use < Command; end

    # Data management
    class Get < Command; end
    class Set < Command; end
    class Delete < Command; end

    # Other

    # Help - lists all the supported commands
    class Help < Command
      def exec
        all_commands = Commands.constants.map { |c| c.to_s.downcase }
        all_commands.delete 'command'
        puts all_commands.sort.join("\n")
      end
    end

    # Version - print the version
    class Version < Command
      def exec
        puts "Gringott (Key -> Value in memory data store) Version: #{VERSION}"
      end
    end
  end

end
