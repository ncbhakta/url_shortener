ENV['APP_ENV'] = 'test'

require 'app'
require 'rack/test'
require 'url_shortener'

describe 'App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  let(:mock_url_shortener) { instance_double(URLShortener) }

  before { allow(URLShortener).to receive(:new).and_return(mock_url_shortener) }

  describe 'POST /' do
    before do
      expect(mock_url_shortener).to receive(:shorten).with('http://cathex.io').and_return('/abc123')
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

  describe 'GET /:short_url' do
    before do
      expect(mock_url_shortener).to receive(:lengthen).with('/abc123').and_return('http://cathex.io')
      get '/abc123'
    end

    describe 'response' do
      it 'has a 301 status' do
        expect(last_response.status).to eq(301)
      end

      it 'redirects to lengthened url' do
        expect(last_response.header['Location']).to eq('http://cathex.io')
      end

      describe 'body' do
        let(:response_body) { JSON.parse(last_response.body) }

        it 'has lengthened url' do
          expect(response_body['url']).to eq('http://cathex.io')
        end
      end
    end
  end
end
