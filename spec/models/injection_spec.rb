require 'rails_helper'

RSpec.describe Injection, type: :model do
  it { is_expected.to validate_presence_of(:dose) }
  it { is_expected.to validate_numericality_of(:dose).is_greater_than(0) }
  it { is_expected.to validate_presence_of(:lot_number) }
  it { is_expected.to validate_length_of(:lot_number).is_equal_to(6) }
  it { is_expected.to belong_to(:patient) }
  it { is_expected.to belong_to(:drug) }

  describe 'validations' do
    describe '#lot_number' do
      it 'is invalid if lot_number contains non-alphanumeric characters' do
        injection = build(:injection, lot_number: '12$%A!')
        expect(injection).not_to be_valid
      end

      it 'is valid with a 6-character alphanumeric lot_number' do
        injection = build(:injection, lot_number: 'A1B2C3')
        expect(injection).to be_valid
      end
    end
  end
end
