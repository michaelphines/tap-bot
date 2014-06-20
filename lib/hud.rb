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

  def initialize
    @title_font = Rubygame::TTF.new(BOLD, 21)
    @brewery_font = Rubygame::TTF.new(REGULAR, 13)
    @style_font = Rubygame::TTF.new(ITALIC, 13)
    @stat_font = Rubygame::TTF.new(BOLD, 21)
    @caption_font = Rubygame::TTF.new(REGULAR, 13)
    @location_font = Rubygame::TTF.new(REGULAR, 16)
  end

  def draw_header(screen, x, y)
    render_text("Eugene", @title_font).blit(screen, [x, y])
    y += @title_font.line_skip

    render_text("Revolution Brewery", @brewery_font).blit(screen, [x, y])
    y += @brewery_font.line_skip

    render_text("American Porter", @style_font).blit(screen, [x, y])
    y += @style_font.line_skip * 1.5

    y
  end

  def draw_footer(screen, x, bottom)
    print_at_centerx_bottom(screen, "Chicago, Illinois, USA", @location_font, X_MAX / 2, bottom)

    bottom - @location_font.line_skip * 1.5
  end

  def draw_stats(screen, x, bottom)
    free_width = X_MAX - X_MARGIN * 2
    x_offset = free_width / 4

    draw_stat(screen, "6.8", "ABV", x + x_offset, bottom)
    draw_stat(screen, "3.78", "Rating", x + x_offset * 2, bottom)
    draw_stat(screen, "28", "IBU", x + x_offset * 3, bottom)
  end

  def draw_stat(screen, value, caption, centerx, caption_bottom)
    print_at_centerx_bottom(screen, caption, @caption_font, centerx, caption_bottom)
    print_at_centerx_bottom(screen, value, @stat_font, centerx, caption_bottom - @caption_font.line_skip)
  end

  def print_at_centerx_bottom(screen, text, font, centerx, bottom)
    surface = render_text(text, font)
    rect = surface.make_rect
    rect.centerx = centerx
    rect.bottom = bottom
    surface.blit(screen, rect)
  end

  def render_text(text, font)
    font.render_utf8(text, true, FOREGROUND, BACKGROUND)
  end

  def draw(screen)
    header_end = draw_header(screen, X_MARGIN, Y_MARGIN)
    footer_begin = draw_footer(screen, X_MARGIN, Y_MAX - Y_MARGIN)
    draw_stats(screen, X_MARGIN, footer_begin)
  end
end
