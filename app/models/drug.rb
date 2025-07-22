class Drug < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :injections, dependent: :destroy
end
