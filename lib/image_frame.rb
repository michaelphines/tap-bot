require 'image'

class ImageFrame
  include Rubygame::Sprites::Sprite

  def initialize(beer_info, size)
    @size = [size.min, size.min]
    @fit_size = [size.min / 2, size.min / 2]
    @beer_info = beer_info
  end

  def update(tick_event)
    return if @beer_info.photos.nil? || @beer_info.photos.empty?

    @image = Rubygame::Surface.new(@size)

    images = @beer_info.photos.map { |p| Image.load_from_string(p).fit_to(@fit_size) }

    images[0].blit(@image, [0, 0])
    images[1].blit(@image, [@fit_size.first, 0])
    images[3].blit(@image, [0, @fit_size.last])
    images[4].blit(@image, @fit_size)
  end

  def draw(screen, center_rect)
    return unless @image

    rect = @image.make_rect
    rect.center = center_rect.center
    @image.blit(screen, rect)
  end
end
