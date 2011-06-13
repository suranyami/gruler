namespace :reactor do
  desc 'Run the reactor in the foreground'
  task :run do
    result = system "ruby ./vendor/plugins/reactor/lib/reactor/reactor_daemon.rb run"
    puts "Reactor daemon #{result ? 'ran successfully' : 'FAILED TO RUN'}."
  end
  
  desc 'Start the reactor'
  task :start do
    result = system "ruby ./vendor/plugins/reactor/lib/reactor/reactor_daemon.rb start"
    puts "Reactor daemon #{result ? 'started successfully' : 'FAILED TO START'}."
  end
  
  
  desc 'Stop the reactor'
  task :stop => :environment do
    result = system "ruby ./vendor/plugins/reactor/lib/reactor/reactor_daemon.rb stop"
    puts "Reactor daemon #{result ? 'stopped successfully' : 'FAILED TO STOP'}."
  end

end