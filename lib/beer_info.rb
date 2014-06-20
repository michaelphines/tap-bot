require 'keg_bot_api'
require 'untappd_api'

class BeerInfo < Hashie::Mash
  REFRESH_RATE = 5 * 60

  class << self
    def untappd_api
      @untappd_api ||= UntappdApi.new
    end
    def keg_bot_api
      @keg_bot_api ||= KegBotApi.new
    end
  end

  def info
    keg_bot_info.merge(untappd_info)
  end

  def keg_bot_info
    response = self.class.keg_bot_api.tap(AppConfig.active_tap)

    beer = response.current_keg.beverage
    brewer = beer.producer

    Hashie::Mash.new(
      :name => beer.name,
      :brewery => brewer.name,
      :city => brewer.origin_city,
      :state => brewer.origin_state,
      :country => brewer.country
    )
  end

  def untappd_info
    name_and_brewery = "#{keg_bot_info.name} #{keg_bot_info.brewery}"
    self.class.untappd_api.search_and_show(name_and_brewery)
  end

  def begin_updates!
    return if @update_thread
    @update_thread = Thread.new do
      replace(info)
      sleep REFRESH_RATE
    end
  end
end
