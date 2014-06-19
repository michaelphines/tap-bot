class TapBot
  ORIGIN = [0, 0]
  DIMENSIONS = [240, 320]
  DEFAULT_COLOR = 0
  LOGO_FILE = File.expand_path("../../assets/groupon.png", __FILE__)

  class << self
    def fit_ratio(size, fit_size, max_zoom = 1)
      width_ratio = fit_size.first.to_f / size.first
      height_ratio = fit_size.last.to_f / size.last

      [max_zoom, width_ratio, height_ratio].min
    end
  end

  def logo_image
    @logo_image ||= begin
      image = Rubygame::Surface.load(LOGO_FILE)
      ratio = self.class.fit_ratio(image.size, DIMENSIONS)
      image.zoom(ratio, true)
    end
  end

  def screen
    @screen ||= begin
      screen = Rubygame::Screen.open(DIMENSIONS, DEFAULT_COLOR, [Rubygame::FULLSCREEN, Rubygame::HWSURFACE])
      screen.show_cursor = false

      screen
    end
  end

  def run
    puts "Started"

    logo_image.blit(screen, ORIGIN)

    loop do
      screen.update
      sleep 1
    end
  end
end
