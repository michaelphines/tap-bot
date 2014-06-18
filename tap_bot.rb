if __FILE__ == $0
  require 'rubygems'
  require 'bundler/setup'
end

require 'rubygame'

class TapBot
  def run
    puts "Hello Tap Bot!"
  end
end

if __FILE__ == $0
  Rubygame.init
  at_exit { Rubygame.quit }

  TapBot.new.run
end
