require 'image'

class AnimatedImage
  include Rubygame::Sprites::Sprite

  def initialize(folder_or_images)
    super()

    if Array === folder_or_images
      @images = folder_or_images
    else
      glob = File.join(folder_or_images, "*")
      files = Dir[glob].sort
      @images = files.map { |f| Image.load(f) }
    end

    @image = @images.first
    @rect = @image.make_rect
    @index = 0
    @ticks = 0
    @rate = 0.03
  end

  def update(tick_event)
    @ticks += tick_event.seconds / @rate
    @ticks = @ticks % @images.length
    @image = @images[@ticks.floor % @images.length]
  end

  def width
    @image.width
  end

  def height
    @image.height
  end

  def draw(screen, center_rect)
    rect = @image.make_rect
    rect.center = center_rect.center
    @image.blit(screen, rect)
  end

  def fit_to(dimensions)
    fitted_images = @images.map { |i| i.fit_to(dimensions) }
    AnimatedImage.new(fitted_images)
  end
end
