require 'fileutils'

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
    class Create < Command
      def exec
        vault_name = @args.first
        Vault.create(vault_name)
        'OK'
      end
    end

    # Drop a vault and all the data associated with it
    class Drop < Command
      def exec
        vault_name = @args.first
        vault = Vault.new(vault_name)
        puts "Do you really want to drop the vault #{vault_name} (y/N)"

        input = gets.strip

        if input == 'y'
          vault.drop
          'OK'
        end
      end
    end

    # List - lists down all the available vaults in the current directory
    class List < Command
      def exec
        vaults = Vault.list

        if vaults.empty?
          puts "No vaults found."
        else
          puts "Found: #{vaults.length} \n#{vaults.join("\n")}"
        end
      end
    end

    # Use command is used to change a vault
    class Use < Command
      def exec
        vault_name = @args.first
        Griphook.use_vault(Vault.new(vault_name))
        CLI.set_prompt(vault_name)
      end
    end

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
