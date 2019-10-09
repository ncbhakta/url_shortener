require 'url_datastore'

describe URLDatastore do
  let(:url_datastore) { described_class.instance }
  let(:num_existing_urls) { 10 }

  let(:urls) do
    (1..num_existing_urls).map { |i| "http://url#{i}.io" }
  end


  before do
    Singleton.__init__(described_class)
    url_datastore.instance_variable_set(:@data, urls)
  end

  it 'is a singleton' do
    expect(described_class).to respond_to(:instance)
  end

  describe '#index' do
    context 'when url exists' do
      it 'returns index of url' do
        expect(url_datastore.index(urls.last)).to eq(num_existing_urls - 1)
      end
    end

    context 'when url does not exist' do
      let(:non_existing_url) { "http://url#{num_existing_urls + 1}.io" }

      it 'returns nil' do
        expect(url_datastore.index(non_existing_url)).to be_nil
      end
    end
  end

  describe '#exists?' do
    context 'when url exists' do
      it 'is true' do
        expect(url_datastore.exists?(urls.last)).to be true
      end
    end

    context 'when url does not exist' do
      let(:non_existing_url) { "http://url#{num_existing_urls + 1}.io" }

      it 'is false' do
        expect(url_datastore.exists?(non_existing_url)).to be false
      end
    end
  end

  describe '#add' do
    context 'when url is not new' do
      it 'does not store duplicate' do
        url_datastore.add(urls.last)
        expect(url_datastore.send(:size)).to eq(num_existing_urls)
      end
    end

    context 'when url is new' do
      let(:non_existing_url) { "http://url#{num_existing_urls + 1}.io" }

      it 'stores url' do
        url_datastore.add(non_existing_url)
        expect(url_datastore.index(non_existing_url)).to eq(num_existing_urls)
      end
    end
  end

  describe '#url' do
    it 'returns the url with the given index' do
      expect(url_datastore.url(num_existing_urls - 1)).to eq(urls.last)
    end
  end
end
