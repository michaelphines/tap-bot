require 'rubygame'

class Hud
  FONT_DIR = File.expand_path("../../assets/fonts", __FILE__)

  REGULAR = File.expand_path("Trebuc.ttf", FONT_DIR)
  ITALIC = File.expand_path("Trebucit.ttf", FONT_DIR)
  BOLD = File.expand_path("Trebucbd.ttf", FONT_DIR)
  BOLD_ITALIC = File.expand_path("Trebucbi.ttf", FONT_DIR)

  X_MARGIN = 10
  Y_MARGIN = 10
  X_MAX = 240
  Y_MAX = 320

  FOREGROUND = [255, 255, 255]
  BACKGROUND = [0, 0, 0]

  attr_reader :beer_info
  attr_reader :screen

  def initialize(screen, beer_info)
    @screen = screen
    @beer_info = beer_info

    @title_font = Rubygame::TTF.new(BOLD, 21)
    @brewery_font = Rubygame::TTF.new(REGULAR, 13)
    @style_font = Rubygame::TTF.new(ITALIC, 13)
    @stat_font = Rubygame::TTF.new(BOLD, 21)
    @caption_font = Rubygame::TTF.new(REGULAR, 13)
    @location_font = Rubygame::TTF.new(REGULAR, 16)
  end

  def header_height
    Y_MARGIN + @title_font.line_skip + @brewery_font.line_skip + @style_font.line_skip * 2
  end

  def footer_height
    Y_MARGIN + @stat_font.line_skip * 1.5 + @caption_font.line_skip + @location_font.line_skip * 2
  end

  def window
    Rubygame::Rect.new(
      X_MARGIN,
      header_height,
      X_MAX - X_MARGIN * 2,
      Y_MAX - header_height - footer_height
    )
  end

  def draw_header(x, y)
    render_text(beer_info.name || "Loading...", @title_font).blit(screen, [x, y])
    y += @title_font.line_skip

    render_text(beer_info.brewery, @brewery_font).blit(screen, [x, y])
    y += @brewery_font.line_skip

    render_text(beer_info.style, @style_font).blit(screen, [x, y])
  end

  def draw_footer(x, bottom)
    footer = [beer_info.city, beer_info.state, beer_info.country].compact.join(", ")
    print_at_centerx_bottom(footer, @location_font, X_MAX / 2, bottom)

    bottom -= @location_font.line_skip * 1.5

    free_width = X_MAX - X_MARGIN * 2
    offsetx = free_width / 4

    draw_stat(beer_info.abv, "ABV", x + offsetx, bottom)
    draw_stat(beer_info.rating, "Rating", x + offsetx * 2, bottom)
    draw_stat(beer_info.ibu, "IBU", x + offsetx * 3, bottom)
  end

  def draw_stat(value, caption, centerx, caption_bottom)
    print_at_centerx_bottom(caption, @caption_font, centerx, caption_bottom)
    print_at_centerx_bottom(value, @stat_font, centerx, caption_bottom - @caption_font.line_skip)
  end

  def print_at_centerx_bottom(text, font, centerx, bottom)
    surface = render_text(text, font)
    rect = surface.make_rect
    rect.centerx = centerx
    rect.bottom = bottom
    surface.blit(screen, rect)
  end

  def render_text(text, font)
    text = " " if text.nil? || text.empty?
    font.render_utf8(text || " ", true, FOREGROUND, BACKGROUND)
  end

  def draw
    draw_header(X_MARGIN, Y_MARGIN)
    draw_footer(X_MARGIN, Y_MAX - Y_MARGIN)
  end
end
