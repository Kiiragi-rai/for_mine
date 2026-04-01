FactoryBot.define do
  factory :partner do
    name { "testpartner" }
    association :user, factory: :user
  end
end
