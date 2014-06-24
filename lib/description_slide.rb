require 'image'

class DescriptionSlide
  include Rubygame::Sprites::Sprite

  FONT_DIR = File.expand_path("../../assets/fonts", __FILE__)
  REGULAR = File.expand_path("Trebuc.ttf", FONT_DIR)
  FOREGROUND = [255,255,255]
  BACKGROUND = [0,0,0]

  def initialize(beer_info, size)
    @size = size
    @beer_info = beer_info
    @lines = []
    @font = Rubygame::TTF.new(REGULAR, 10)
  end

  def ready?
    !@beer_info.description.nil? && !@beer_info.description.empty?
  end

  def update(tick_event)
    @lines = []
    current_line = ""
    @beer_info.description.split(/\s/).each do |word|
      potential_width = @font.size_text(current_line + word).first
      if potential_width > @size.first
        @lines << current_line
        current_line = word + " "
      else
        current_line << word + " "
      end
    end
    @lines << current_line
  end

  def draw(screen, rect)
    x = rect.x
    y = rect.y

    @lines.each do |line|
      render_text(line, @font).blit(screen, [x, y])
      y += @font.line_skip
    end
  end

  def render_text(text, font)
    font.render_utf8(text || " ", true, FOREGROUND, BACKGROUND)
  end
end
