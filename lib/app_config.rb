require 'yaml'
require 'hashie'

AppConfig = Hashie::Mash.new(YAML.load_file(File.expand_path("../../config.yml", __FILE__)))
