FactoryBot.define do
  factory :user do
    name {"testuser"}
    provider {"line"}
    uid { SecureRandom.uuid}
  end
end