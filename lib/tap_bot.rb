require 'hud'
require 'animated_logo'

class TapBot
  ORIGIN = [0, 0]
  WIDTH = 240
  HEIGHT = 320
  DIMENSIONS = [WIDTH, HEIGHT]
  DEFAULT_COLOR = 0
  ANIMATION_DIR = File.expand_path("../../assets/animated_logo", __FILE__)
  LOGO = File.expand_path("../../assets/groupon.png", __FILE__)

  def initialize
    @screen = Rubygame::Screen.open(DIMENSIONS, DEFAULT_COLOR, [Rubygame::FULLSCREEN])

    @screen.show_cursor = false

    @clock = Rubygame::Clock.new
    @clock.target_framerate = 30
    @clock.enable_tick_events

    @animated_logo = AnimatedImage.new(ANIMATION_DIR).fit_to(DIMENSIONS)
    remaining_height = HEIGHT - @animated_logo.height
    @logo = Image.load(LOGO).fit_to([WIDTH, remaining_height])
    @x = [WIDTH - @logo.width, 0].max / 2
    @y = HEIGHT - @logo.height

    @hud = Hud.new
  end

  def run
    loop do
      tick_event = @clock.tick

      @hud.draw(@screen)
      @screen.flip
    end
  end
end
