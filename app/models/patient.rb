class Patient < ApplicationRecord
  validates :name, presence: true
  validates :api_key, presence: true, uniqueness: true

  before_validation :generate_api_key, on: :create

  has_many :injections, dependent: :destroy

  def self.ransackable_attributes(_ = nil)
    %w[created_at id name updated_at]
  end

  def self.ransackable_associations(_ = nil)
    ["injections"]
  end

  private

  def generate_api_key
    self.api_key ||= loop do
      token = SecureRandom.hex(20)
      # Ensure the generated token is unique
      break token unless Patient.exists?(api_key: token)
    end
  end
end
