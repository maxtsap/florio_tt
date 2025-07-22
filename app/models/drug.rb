class Drug < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :injections, dependent: :destroy

  def self.ransackable_attributes(_ = nil)
    %w[created_at id name updated_at]
  end

  def self.ransackable_associations(_ = nil)
    ["injections"]
  end
end
