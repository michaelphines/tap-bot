class SlideDeck
  ROTATION_RATE = 10

  def initialize(rate = nil)
    @ticks = 0
    @slides = []
    @pending_slides = []
    @rate ||= ROTATION_RATE
  end

  def <<(slide)
    @pending_slides << slide
  end

  def active_slide
    @slides[@ticks.floor % @slides.length]
  end

  def update(tick_event)
    @slides, @pending_slides = (@slides + @pending_slides).partition(&:ready?)

    @ticks += tick_event.seconds / @rate
    @ticks = @ticks % @slides.length

    active_slide.update(tick_event)
  end

  def draw(screen, rect)
    active_slide.draw(screen, rect)
  end
end
