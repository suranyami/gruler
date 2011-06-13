# lib/name_of_our_gem/railtie.rb
require 'gruler'
require 'rails'
module Gruler
  class Railtie < Rails::Railtie
    config.reactor = ActiveSupport::OrderedOptions.new

    initializer "reactor.init" do |app|
      REACTOR_DIR = File.join(Rails.root, "lib", "gruler")
      TASKS_DIR = File.join(REACTOR_DIR, "tasks")
    end
  end

end
