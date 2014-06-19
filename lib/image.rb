class Image < Rubygame::Surface
  def fit_to(dimensions, max_zoom = 1)
    width_ratio = dimensions.first.to_f / size.first
    height_ratio = dimensions.last.to_f / size.last
    ratio = [max_zoom, width_ratio, height_ratio].min

    self.zoom(ratio, true)
  end
end
