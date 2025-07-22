class Injection < ApplicationRecord
  validates :dose, presence: true, numericality: { greater_than: 0 }
  validates :lot_number,
            presence: true,
            length: { is: 6 },
            format: { with: /\A[A-Za-z0-9]+\z/, message: 'must be alphanumeric' }

  belongs_to :patient
  belongs_to :drug
end
