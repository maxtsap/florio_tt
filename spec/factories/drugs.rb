FactoryBot.define do
  factory :drug do
    sequence(:name) { |n| "Drug #{n}" }
  end
end
