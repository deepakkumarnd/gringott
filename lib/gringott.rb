autoload :VERSION, "gringott/version"
require 'gringott/vault'
require 'gringott/vault_manager'

module Gringott
  autoload :CLI, "gringott/cli"
  autoload :Commands, "gringott/commands"

  class Error < StandardError; end
  class CommandError < Error; end
end
