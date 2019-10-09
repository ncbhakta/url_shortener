require 'base_converter'

describe BaseConverter do

  subject { Object.new.extend(described_class) }

  describe '#base_10_to_62' do
    it 'converts base 10 to base 62' do
      expect(subject.base_10_to_62('0')).to eq('0')
      expect(subject.base_10_to_62('33536566819')).to eq('abc123')
    end
  end

  describe '#base_62_to_10' do
    it 'converts base 62 to base 10' do
      expect(subject.base_62_to_10('0')).to eq('0')
      expect(subject.base_62_to_10('abc123')).to eq('33536566819')
    end
  end
end
