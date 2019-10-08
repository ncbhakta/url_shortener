require 'url_datastore'
require 'url_shortener'

describe URLShortener do
  let(:url) { 'http://cathex.io' }
  let(:base62) { 'abc123'}
  let(:base10) { '33536566819'}
  let(:index) { base10.to_i }
  let(:short_url) { "/#{base62}" }
  let(:mock_url_datastore) { instance_double(URLDatastore) }
  let(:url_shortener) { URLShortener.new }

  before do
    allow(URLDatastore).to receive(:new).and_return(mock_url_datastore)
    allow(url_shortener).to receive(:base_10_to_62).with(base10).and_return(base62)
    allow(mock_url_datastore).to receive(:index).with(url).and_return(index)
  end

  describe '#shorten' do
    context 'when url is not new' do
      before do
        allow(mock_url_datastore).to receive(:exists?).with(url).and_return(true)
      end

      it 'does not add url to datastore' do
        expect(mock_url_datastore).not_to receive(:add)
        url_shortener.shorten(url)
      end

      it "returns base 62 form of url's index" do
        expect(url_shortener.shorten(url)).to eq(short_url)
      end
    end

    context 'when url is new' do
      before do
        allow(mock_url_datastore).to receive(:exists?).with(url).and_return(false)
      end

      it 'adds url to datastore' do
        expect(mock_url_datastore).to receive(:add).with(url)
        url_shortener.shorten(url)
      end

      it "returns base 62 form of url's index" do
        allow(mock_url_datastore).to receive(:add).with(url)
        expect(url_shortener.shorten(url)).to eq(short_url)
      end
    end

  end

  describe '#lengthen' do
    it "returns url indexed at base 10 form of short_url"
  end
end
