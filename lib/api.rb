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
  rescue StandardError => e
    STDERR.puts "Error in request:"
    STDERR.puts e.message
    e.backtrace.each { |l| STDERR.puts l }
    nil
  end
end
