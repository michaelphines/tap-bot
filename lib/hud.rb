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

  def initialize
    @title_font = Rubygame::TTF.new(BOLD, 21)
    @brewery_font = Rubygame::TTF.new(REGULAR, 13)
    @style_font = Rubygame::TTF.new(ITALIC, 13)
    @stat_font = Rubygame::TTF.new(BOLD, 21)
    @caption_font = Rubygame::TTF.new(REGULAR, 13)
    @location_font = Rubygame::TTF.new(REGULAR, 16)
  end

  def draw_header(screen, x, y)
    @title_font.render_utf8("Eugene", true, [255,255,255], [0,0,0]).blit(screen, [x, y])
    y += @title_font.line_skip

    @brewery_font.render_utf8("Revolution Brewery", true, [255,255,255], [0,0,0]).blit(screen, [x, y])
    y += @brewery_font.line_skip

    @style_font.render_utf8("American Porter", true, [255,255,255], [0,0,0]).blit(screen, [x, y])
    y += @style_font.line_skip * 1.5

    y
  end

  def draw_footer(screen, x, bottom)
    location = @location_font.render_utf8("Chicago, Illinois, USA", true, [255,255,255], [0,0,0])
    location_rect = location.make_rect
    location_rect.centerx = X_MAX / 2
    location_rect.bottom = bottom
    location.blit(screen, location_rect)

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
    stat_bottom = caption_bottom - @caption_font.line_skip

    caption = @caption_font.render_utf8(caption, true, [255,255,255], [0,0,0])
    caption_rect = caption.make_rect
    caption_rect.centerx = centerx
    caption_rect.bottom = caption_bottom
    caption.blit(screen, caption_rect)

    stat = @stat_font.render_utf8(value, true, [255,255,255], [0,0,0])
    stat_rect = stat.make_rect
    stat_rect.centerx = centerx
    stat_rect.bottom = stat_bottom
    stat.blit(screen, stat_rect)
  end

  def draw(screen)
    header_end = draw_header(screen, X_MARGIN, Y_MARGIN)
    footer_begin = draw_footer(screen, X_MARGIN, Y_MAX - Y_MARGIN)
    draw_stats(screen, X_MARGIN, footer_begin)
  end
end
