FactoryBot.define do
  factory :injection do
    dose { 1 }
    lot_number { "123ABC" }
    patient
    drug
  end
end
