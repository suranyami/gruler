require 'eventmachine'

require 'gruler/core'
require 'gruler/runner'

module Gruler
  require 'lib/gruler/railtie' if defined?(Rails)
end
