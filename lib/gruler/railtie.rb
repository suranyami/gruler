# lib/name_of_our_gem/railtie.rb
require 'gruler'
require 'rails'
module Gruler
  class Railtie < Rails::Railtie
    config.gruler = ActiveSupport::OrderedOptions.new

    initializer "gruler.init" do |app|
      GRULER_DIR = File.join(Rails.root, "lib", "gruler")
      TASKS_DIR = File.join(GRULER_DIR, "tasks")
    end
  end

end
