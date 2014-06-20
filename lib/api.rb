require 'json'
require 'httparty'

class Api
  include HTTParty

  attr_accessor :defaults

  def initialize(options = {})
    self.defaults = options
  end

  def get(url, options = {})
    Hashie::Mash.new(self.class.get(url, :query => defaults.merge(options)).parsed_response)
  rescue
    STDERR.puts "Error in request."
    nil
  end
end
