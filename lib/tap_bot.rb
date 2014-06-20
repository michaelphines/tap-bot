require 'hud'
require 'beer_info'
require 'slide_deck'
require 'image_frame'
require 'animated_logo'

class TapBot
  ORIGIN = [0, 0]
  WIDTH = 240
  HEIGHT = 320
  DIMENSIONS = [WIDTH, HEIGHT]
  DEFAULT_COLOR_DEPTH = 0
  BACKGROUND_COLOR = [0, 0, 0]
  ANIMATION_DIR = File.expand_path("../../assets/animated_logo", __FILE__)
  LOGO = File.expand_path("../../assets/groupon.png", __FILE__)

  def initialize
    beer_info = BeerInfo.new
    beer_info.begin_updates!

    @screen = Rubygame::Screen.open(DIMENSIONS, DEFAULT_COLOR_DEPTH, [Rubygame::FULLSCREEN])

    @background = Rubygame::Surface.new(DIMENSIONS)
    @background.fill(BACKGROUND_COLOR)

    @screen.show_cursor = false

    @clock = Rubygame::Clock.new
    @clock.target_framerate = 30
    @clock.enable_tick_events

    @hud = Hud.new(@screen, beer_info)
    @slide_deck = SlideDeck.new
    @slide_deck << AnimatedImage.new(ANIMATION_DIR).fit_to(@hud.window.size)
    @slide_deck << ImageFrame.new(beer_info, @hud.window.size)

  end

  def run
    loop do
      tick_event = @clock.tick

      @slide_deck.update(tick_event)

      @background.blit(@screen, [0, 0])
      @slide_deck.draw(@screen, @hud.window)
      @hud.draw

      @screen.flip
    end
  end
end
