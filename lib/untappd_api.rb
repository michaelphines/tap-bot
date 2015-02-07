require 'api'
require 'app_config'

class UntappdApi < Api
  base_uri AppConfig.untappd.base

  MAX_LENGTH = 575

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

  def minimize_description(description)
    collapsed_description = description.gsub(/\s+/, " ")
    if collapsed_description.length > MAX_LENGTH
      collapsed_description[0..MAX_LENGTH].rstrip + "..."
    else
      collapsed_description
    end
  end

  def show(id)
    results = get(AppConfig.untappd.show, :kimpath2 => id).results
    details = results.details.first
    photos = results.photos.map { |p| HTTParty.get(p.photo.src).parsed_response }

    details.merge(
      :description => details.description && minimize_description(details.description),
      :photos => photos
    )
  end
end
