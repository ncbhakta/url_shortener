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

get '/:short_url' do
  content_type :json

  short_url = "/#{params[:short_url]}"
  url = URLShortener.new.lengthen(short_url)

  redirect url, 301, { url: url }.to_json
end
