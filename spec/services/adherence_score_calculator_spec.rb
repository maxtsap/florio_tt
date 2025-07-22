# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdherenceScoreCalculator do
  describe '#calculate' do
    subject { described_class.new(patient, reference_date: reference_date).calculate }

    let(:patient) { create(:patient, created_at: Date.new(2025, 1, 1)) }
    let(:drug) { create(:drug) }
    let(:reference_date) { Date.new(2025, 1, 12) }
    let(:calculator) { described_class.new(patient, reference_date) }

    before do
      injection_dates.each do |day|
        create(:injection, patient: patient, drug: drug, created_at: Date.new(2025, 1, day))
      end
    end

    context 'when patient has followed the schedule perfectly' do
      let(:injection_dates) { [1, 4, 7, 10] }

      it { is_expected.to eq(100) }
    end

    context 'when patient has missed some injections' do
      let(:injection_dates) { [1, 4] }

      it { is_expected.to eq(50) }
    end

    context 'when patient has no expected injections' do
      let(:injection_dates) { [] }

      it { is_expected.to eq(0) }
    end
  end
end
