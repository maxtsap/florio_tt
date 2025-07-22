# frozen_string_literal: true

class AdherenceScoreCalculator
  def initialize(patient, start_date: nil, reference_date: Date.today)
    @patient = patient
    @start_date = start_date || @patient.created_at
    @reference_date = reference_date
  end

  def calculate
    ((on_time_injections.count.to_f / expected_injections.count) * 100).round(0)
  end

  private

  def expected_injections
    (@start_date.to_date..@reference_date).step(3.days).to_a
  end

  def actual_injections
    @patient.injections.where(created_at: (@start_date..@reference_date)).pluck(:created_at).map(&:to_date)
  end

  def on_time_injections
    expected_injections & actual_injections
  end
end
