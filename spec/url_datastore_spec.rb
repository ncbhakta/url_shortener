require 'url_datastore'

describe URLDatastore do
  describe '#index' do
    it 'returns index of url'
  end

  describe '#exists?' do
    context 'when url exists' do
      it 'is true'
    end

    context 'when url does not exist' do
      it 'is false'
    end
  end

  describe '#add' do
    context 'when url is not new' do
      it 'does not store duplicate'
    end

    context 'when url is new' do
      it 'stores url'
    end
  end
end
