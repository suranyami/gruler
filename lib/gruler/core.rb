module Reactor
  class Core
    attr_accessor :rules
    def initialize(rules = [])
      @rules = {}
      rules.each do |rule|
        @rules[rule.event_name] = [] unless @rules[rule.event_name]
        @rules[rule.event_name] << rule.content
      end
    end

    def react(event)
      rules = @rules[event.name]
      rules.each {|rule| rule.evaluate(binding)}
      event.destroy
    end
  end
end
