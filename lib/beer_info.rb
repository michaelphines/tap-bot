require 'keg_bot_api'
require 'untappd_api'

class BeerInfo < Hashie::Mash
  class << self
    def untappd_api
      @untappd_api ||= UntappdApi.new
    end
    def keg_bot_api
      @keg_bot_api ||= KegBotApi.new
    end
  end

  def initialize
    @tap = AppConfig.active_tap
    super(info)
  end

  def info
    @info ||= keg_bot_info.merge(untappd_info)
  end

  def keg_bot_info
    return @keg_bot_info if @keg_bot_info

    response = self.class.keg_bot_api.tap(@tap)

    beer = response.current_keg.beverage
    brewer = beer.producer

    @keg_bot_info = Hashie::Mash.new(
      :name => beer.name,
      :brewery => brewer.name,
      :city => brewer.origin_city,
      :state => brewer.origin_state,
      :country => brewer.country
    )
  end

  def untappd_info
    name_and_brewery = "#{keg_bot_info.name} #{keg_bot_info.brewery}"
    @untappd_info ||= self.class.untappd_api.search_and_show(name_and_brewery)
  end
end
