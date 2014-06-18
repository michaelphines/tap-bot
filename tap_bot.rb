if __FILE__ == $0
  require 'rubygems'
  require 'bundler/setup'
end

require 'rubygame'

class TapBot
  ORIGIN = [0, 0]

  def run
    file = File.expand_path("../assets/groupon.png", __FILE__)
    image = Rubygame::Surface.load(file)
    screen = Rubygame::Screen.open(image.size)
    screen.title = File.basename(file)
    image.blit(screen, ORIGIN)

    loop do
      screen.update
      sleep 0.1
    end
  end
end

if __FILE__ == $0
  Rubygame.init
  at_exit { Rubygame.quit }

  TapBot.new.run
end
