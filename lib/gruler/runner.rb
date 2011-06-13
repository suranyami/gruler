require 'eventmachine'
require 'em-websocket'

module Gruler
  class Runner
    @@server_options = {:host => "127.0.0.1", :port => 8090}
    @@error_handler = lambda { |e|
      Gruler::Runner.log "Exception:  #{e}.  Backtrace:  #{e.backtrace.join("\n") rescue ''}"
    }
    

    def run(options = [])
      puts "Loaded #{Rails.env} environment"
      puts "Starting Gruler at #{now}"
      @gruler = Gruler::Core.new(Rule.all)
      @sockets = []
      @count = 0
      @state = {}
      
      EventMachine.run do
        @notification_channel = EM::Channel.new
        
        generate_events
        consume_events
        
        EventMachine::WebSocket.start(:host => "127.0.0.1", :port => 8090) do |socket|
          socket.onopen do
            @sockets << socket
            @state[socket] = {}
            log "Socket opened"
            sid = @notification_channel.subscribe do |msg|
              socket.send msg
            end
          end
              
          socket.onmessage do |mess|
            @sockets.each do |s|
              log "Message: #{mess}"
              s.send mess
            end
          end
              
          socket.onclose do
            @sockets.delete socket
            log "Socket closed"
          end
        end
        
      end

      puts "Gruler terminated at #{now}"
    end
    
    def log(message)
      logger.info "Gruler::Runner [#{now}]:  #{message}"
    end

    def handle_error(e)
      @error_handler.call(e)
    rescue
      details = "Exception:  #{e}."
      details += "  Backtrace:  #{e.backtrace.join("\n")}" if e.backtrace
      log details rescue $stderr.puts details
    end

    def consume_events
      EventMachine::defer do
        while true do
          event = Event.next_unhandled
          if event
            @gruler.react(event)
            log("Consumed event #{event}")
          else
            log("No events.")
          end
          sleep(0.1)
        end
      end
    end

    def generate_events
      EventMachine::defer do
        10.times do |count|
          event = Factory.create(:event)
          log("Event created: #{event}")
          sleep(0.1)
        end
      end
    end

    THINGIES = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".chars.to_a

    def generate_char_events
      EventMachine::defer do
        while true do
          c = THINGIES[@count]
          @channel.push c
          @count += 1
          @count = 0 if @count >= THINGIES.size
          sleep(0.1)
          puts @count
        end
      end
    end

    private
    def now
      (Time.respond_to?(:zone) && Time.zone) ? Time.zone.now.to_s : Time.now.to_s
    end

    def logger
      @logger ||= if defined?(Rails.logger)
        Rails.logger
      elsif defined?(RAILS_DEFAULT_LOGGER)
        RAILS_DEFAULT_LOGGER
      else
        Logger.new(STDOUT)
      end
    end
  end
end