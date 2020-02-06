module Gringott

  # Here all the commands are defined as a command class
  module Commands

    # Base class for all commands, a command class responds to an exec method
    class Command

      def initialize(args)
        @args = args
      end

      def exec
        puts "Executing"
      end
    end

    # Vault - create, drop and list
    class Create < Command; end
    class Drop < Command; end
    class List < Command; end

    # Data management
    class Get < Command; end
    class Set < Command; end
    class Delete < Command; end

    # Other
    class Help < Command; end
    class Version < Command; end
  end

end
