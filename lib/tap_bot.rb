require 'animated_logo'

class TapBot
  ORIGIN = [0, 0]
  DIMENSIONS = [240, 320]
  DEFAULT_COLOR = 0
  LOGO = File.expand_path("../../assets/animated_logo", __FILE__)

  def initialize
    @screen = Rubygame::Screen.open(DIMENSIONS, DEFAULT_COLOR, [Rubygame::FULLSCREEN])

    @screen.show_cursor = false

    @clock = Rubygame::Clock.new
    @clock.target_framerate = 30
    @clock.enable_tick_events

    @animated_logo = AnimatedImage.new(LOGO).fit_to(DIMENSIONS)
  end

  def run
    loop do
      tick_event = @clock.tick
      @animated_logo.update(tick_event.seconds)
      @animated_logo.draw(@screen)
      @screen.flip
    end
  end
end
