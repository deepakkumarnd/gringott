require 'fileutils'

module Gringott

  # Here all the commands are defined as a command class
  module Commands

    # Abstract base class for all commands, a command class responds to an exec method
    class Command

      def initialize(args)
        @args = args
      end

      def exec
        puts "Error: Bad command, type `help` to get a list of supported commands"
      end
    end

    # Vault management - create, drop and list
    class Create < Command
      def exec
        vault_name = @args.first
        Griphook.create_vault(vault_name)
      end
    end

    # Drop a vault and all the data associated with it
    class Drop < Command
      def exec
        vault_name = @args.first
        puts "Do you really want to drop the vault #{vault_name} (y/N)"

        input = gets.strip

        if input == 'y'
          Griphook.drop_vault(vault_name)
        end
      end
    end

    # List - lists down all the available vaults in the current directory
    class List < Command
      def exec
        vaults = Griphook.list_vaults

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
        Griphook.use_vault(vault_name)
        CLI.set_prompt(vault_name)
      end
    end

    # Data management
    class Get < Command
      def exec
        key = @args.first
        value = Griphook.get(key)
        
        if value.nil?
          puts "Error, No such key `#{key}` found!"
        else
          puts value
        end
      end
    end

    # Set a key in memory
    class Set < Command
      def exec
        key, value = @args
        Griphook.set(key, value)
      end
    end

    # Delete removes a key value pair from the store
    class Delete < Command
      def exec
        key = @args.first
        Griphook.delete(key)
      end
    end

    class Stats < Command
      def exec
        stats = Griphook.stats
        puts "Stats"
        puts stats.map { |key, value| "#{key} => #{value}" }.join("\n")
      end
    end

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
