require 'sinatra'
require_relative './url_shortener'

set :port, 4000

post '/' do
  content_type :json
  request.body.rewind

  url = JSON.parse(request.body.read)['url']
  short_url = URLShortener.new.shorten(url)

  { short_url: short_url, url: url }.to_json
end
