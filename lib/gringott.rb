autoload :VERSION, "gringott/version"


module Gringott
  autoload :CLI, "gringott/cli"
  autoload :Commands, "gringott/commands"

  class Error < StandardError; end
end
