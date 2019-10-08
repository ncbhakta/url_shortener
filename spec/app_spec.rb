ENV['APP_ENV'] = 'test'

require 'app'
require 'rack/test'

describe 'App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
end
