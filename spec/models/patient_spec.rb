require 'rails_helper'

RSpec.describe Patient, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:api_key) }

  describe 'callbacks' do
    it 'generates an API key before creating a patient' do
      patient = Patient.new(name: 'John Doe')
      expect(patient.api_key).to be_nil
      patient.save
      expect(patient.reload.api_key).not_to be_nil
    end
  end
end
