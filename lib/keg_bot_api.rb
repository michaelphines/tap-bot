require 'api'
require 'app_config'

class KegBotApi < Api
  base_uri AppConfig.keg_bot.base

  def tap(name)
    taps.objects.find { |t| t.name == name }
  end

  def taps
    get(AppConfig.keg_bot.taps)
  end
end
