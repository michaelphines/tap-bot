class SlideDeck
  ROTATION_RATE = 30

  def initialize(rate = nil)
    @ticks = 0
    @slides = []
    @rate ||= ROTATION_RATE
  end

  def <<(slide)
    @slides << slide
  end

  def active_slide
    @slides[@ticks.floor % @slides.length]
  end

  def update(tick_event)
    @ticks += tick_event.seconds / @rate
    @ticks = @ticks % @slides.length
    active_slide.update(tick_event)
  end

  def draw(screen, rect)
    active_slide.draw(screen, rect)
  end
end
