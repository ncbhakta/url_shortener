ENV['APP_ENV'] = 'test'

require 'app'
require 'rack/test'
require 'url_shortener'

describe 'App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe 'POST /' do
    before do
      URLShortener.any_instance.stub(:shorten).with('http://cathex.io').and_return('/abc123')
      json = { url: 'http://cathex.io' }.to_json
      post('/', json, { 'CONTENT_TYPE' => 'application/json' })
    end

    describe 'response' do
      it 'has a 200 status' do
        expect(last_response.status).to eq(200)
      end

      describe 'body' do
        let(:response_body) { JSON.parse(last_response.body) }

        it 'has short_url corresponding to posted url' do
          expect(response_body['short_url']).to eq('/abc123')
        end

        it 'has posted url' do
          expect(response_body['url']).to eq('http://cathex.io')
        end
      end
    end
  end
end
