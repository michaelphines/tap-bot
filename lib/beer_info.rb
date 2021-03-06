require 'keg_bot_api'
require 'untappd_api'

class BeerInfo < Hashie::Mash
  REFRESH_RATE = 5 * 60
  RETRY_RATE = 30

  class << self
    def untappd_api
      @untappd_api ||= UntappdApi.new
    end

    def keg_bot_api
      @keg_bot_api ||= KegBotApi.new
    end
  end

  def get_info
    keg_bot_info.merge(untappd_info)
  rescue StandardError => e
    STDERR.puts "Error fetching data:"
    STDERR.puts e.message
    e.backtrace.each { |l| STDERR.puts l }

    nil
  end

  def kegbot_base_info
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

  def file_base_info
    lines = File.readlines(AppConfig.beer_name.filename)

    Hashie::Mash.new(
      :name => lines[0].chomp,
      :brewery => lines[1].chomp,
      :city => lines[2].chomp,
      :state => lines[3].chomp,
      :country => lines[4].chomp
    )
  end

  def keg_bot_info
    begin
      case AppConfig.beer_name.type
      when "file" then file_base_info
      when "kegbot" then kegbot_base_info
      end
    end
  end

  def untappd_info
    name_and_brewery = "#{keg_bot_info.name} #{keg_bot_info.brewery}"
    self.class.untappd_api.search_and_show(name_and_brewery)
  end

  def begin_updates!
    return if @update_thread
    @update_thread = Thread.new do
      loop do
        new_info = get_info
        if new_info
          replace(new_info)
          sleep REFRESH_RATE
        else
          sleep RETRY_RATE
        end
      end
    end
  end
end
