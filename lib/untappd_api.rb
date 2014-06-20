require 'api'
require 'app_config'

class UntappdApi < Api
  base_uri AppConfig.untappd.base

  def initialize(options = {})
    self.defaults = { :apikey => AppConfig.untappd.apikey }.merge(options)
  end

  def search_and_show(query)
    search_response = search(query)
    first_id = search_response.results.first.href[/\d+/]

    show(first_id)
  end

  def search(query)
    get(AppConfig.untappd.search, :q => query).results
  end

  def show(id)
    results = get(AppConfig.untappd.show, :kimpath2 => id).results
    details = results.details.first
    photos = results.photos.map(&:photo)

    details.merge(
      :description => details.description && details.description.gsub(/\s+/, " "),
      :photos => photos
    )
  end
end
