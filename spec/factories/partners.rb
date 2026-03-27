FactoryBot.define do
  factory :partner do
    name { "testpartner" }
    association :user
  end
end
