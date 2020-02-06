# Command line interface

require 'singleton'

module Gringott

  class CLI

    include Singleton
    include Commands

    def initialize
      @prompt = '>> '
    end

    def start
      welcome_message

      loop do
        show_prompt
        command, *args = wait_for_input
        run_command(command, args) unless command.nil?
      end
    end

    private

    def welcome_message
      "Gringott (Key -> Value in memory data store) Version: #{VERSION}"
    end

    def show_prompt
      print @prompt
    end

    def set_prompt(str)
      @prompt = str
    end

    def wait_for_input
      input = gets.strip
      parse_command(input)
    end

    def run_command(command, args)
      case command
      when 'use'
        # Use command is defined in module Commands
        Use.new(args).exec
        set_prompt("#{args[0]} >> ")
      when 'q', 'quit', 'exit'
        puts 'Bye'
        exit
      else
        exec_using_command_klass(command, args)
      end
    end

    def exec_using_command_klass(command, args)
      begin
        command_klass = Kernel.const_get("Gringott::Commands::#{command.capitalize}")
      rescue NameError => e
        puts "Error: Bad command #{command}, type `help` to get a list of supported commands"
        return
      end

      command_klass.new(args).exec
    end

    def parse_command(command_str)
      command_str.gsub(/\s/, ' ').downcase.split(' ')
    end
  end  
end