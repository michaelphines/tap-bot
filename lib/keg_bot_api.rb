require 'api'
require 'app_config'

class KegBotApi < Api
  base_uri AppConfig.beer_name.base

  def tap(name)
    taps.objects.find { |t| t.name == name }
  end

  def taps
    get(AppConfig.beer_name.taps)
  end
end
