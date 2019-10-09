require 'base_converter'

describe BaseConverter do

  subject { Object.new.extend(described_class) }

  describe '#base_10_to_62' do
    it 'converts base 10 to base 62' do
      expect(subject.base_10_to_62('0')).to eq('0')
      expect(subject.base_10_to_62('33536566819')).to eq('abc123')
    end
  end
end
