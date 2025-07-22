class Injection < ApplicationRecord
  validates :dose, presence: true, numericality: { greater_than: 0 }
  validates :lot_number,
            presence: true,
            length: { is: 6 },
            format: { with: /\A[A-Za-z0-9]+\z/, message: 'must be alphanumeric' }

  belongs_to :patient
  belongs_to :drug

  def self.ransackable_attributes(_ = nil)
    %w[created_at dose drug_id id lot_number patient_id updated_at]
  end

  def self.ransackable_associations(_ = nil)
    %w[drug patient]
  end
end
