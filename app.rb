require 'sinatra/base'
require 'sinatra/reloader'
require 'hashie/mash'
require 'httparty'
require 'json'

require_relative 'checkers/checker'
require_relative 'services/api'

class GraphiteNoti < Sinatra::Base
  # Register Plugins
  register Sinatra::Reloader

  # Load config
  configure do
    set :config_alert, Hashie::Mash[JSON.parse(File.read('config.json'))]
  end

  # Register helpers
  helpers   Checkers::Checker
end
