require 'url_datastore'

describe URLDatastore do
  let(:num_existing_urls) { 10 }

  let(:urls) do
    (1..num_existing_urls).map { |i| "http://url#{i}.io" }
  end

  before do
    Singleton.__init__(described_class)
    described_class.instance.instance_variable_set(:@data, urls)
  end

  it 'is a singleton' do
    expect(described_class).to respond_to(:instance)
  end

  describe '#index' do
    context 'when url exists' do
      it 'returns index of url' do
        expect(described_class.instance.index(urls.last)).to eq(num_existing_urls - 1)
      end
    end

    context 'when url does not exist' do
      let(:non_existing_url) { "http://url#{num_existing_urls + 1}.io" }

      it 'returns nil' do
        expect(described_class.instance.index(non_existing_url)).to be_nil
      end
    end
  end

  describe '#exists?' do
    context 'when url exists' do
      it 'is true' do
        expect(described_class.instance.exists?(urls.last)).to be true
      end
    end

    context 'when url does not exist' do
      let(:non_existing_url) { "http://url#{num_existing_urls + 1}.io" }

      it 'is false' do
        expect(described_class.instance.exists?(non_existing_url)).to be false
      end
    end
  end

  describe '#add' do
    context 'when url is not new' do
      it 'does not store duplicate' do
        described_class.instance.add(urls.last)
        expect(described_class.instance.send(:size)).to eq(num_existing_urls)
      end
    end

    context 'when url is new' do
      let(:non_existing_url) { "http://url#{num_existing_urls + 1}.io" }

      it 'stores url' do
        described_class.instance.add(non_existing_url)
        expect(described_class.instance.index(non_existing_url)).to eq(num_existing_urls)
      end
    end
  end

  describe '#url' do
    it 'returns the url with the given index'
  end
end
