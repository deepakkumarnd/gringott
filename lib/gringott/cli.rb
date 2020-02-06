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
        run_command(command, args)
      end
    end

    private

    def welcome_message
      "Gringott version #{VERSION}"
    end

    def show_prompt
      print @prompt
    end

    def wait_for_input
      input = gets.strip
      parse_command(input)
    end

    def run_command(command, args)
      if %w[q quit exit].include?(command)
        puts 'Bye'
        exit
      end

      begin
        command_klass = Kernel.const_get("Gringott::Commands::#{command.capitalize}")
      rescue NameError => e
        puts "Error: Bad command #{command}"
        return
      end

      command_klass.new(args).exec
    end

    def parse_command(command_str)
      command_str.gsub(/\s/, ' ').downcase.split(' ')
    end
  end  
end