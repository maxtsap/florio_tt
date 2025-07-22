require 'rails_helper'

RSpec.describe Patient, type: :model do
  subject { build(:patient, name: "John Doe", api_key: SecureRandom.hex(20)) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:api_key) }
  it { is_expected.to have_many(:injections).dependent(:destroy) }

  describe 'callbacks' do
    it 'generates an API key before creating a patient' do
      patient = Patient.new(name: 'John Doe')
      expect(patient.api_key).to be_nil
      patient.save
      expect(patient.reload.api_key).not_to be_nil
    end
  end
end
