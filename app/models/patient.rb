class Patient < ApplicationRecord
  validates :name, presence: true
  validates :api_key, presence: true, uniqueness: true
end
