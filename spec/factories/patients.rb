FactoryBot.define do
  factory :patient do
    name { 'John Doe' }
    api_key { SecureRandom.hex(20) }
  end
end
