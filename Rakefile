require 'bundler'
Bundler::GemHelper.install_tasks

namespace :gruler do
  desc 'Run the gruler in the foreground'
  task :run do
    result = system "ruby lib/gruler/gruler_daemon run"
    puts "Gruler daemon #{result ? 'ran successfully' : 'FAILED TO RUN'}."
  end
  
  desc 'Start the gruler'
  task :start do
    result = system "ruby lib/gruler/gruler_daemon start"
    puts "Gruler daemon #{result ? 'started successfully' : 'FAILED TO START'}."
  end
  
  
  desc 'Stop the gruler'
  task :stop => :environment do
    result = system "ruby lib/gruler/gruler_daemon stop"
    puts "Gruler daemon #{result ? 'stopped successfully' : 'FAILED TO STOP'}."
  end

end