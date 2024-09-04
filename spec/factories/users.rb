FactoryBot.define do
  factory :user do
    email { "phvfs19@gmail.com" }
    password { "123456" }
    password_confirmation { "123456" }

    provider { nil }
    provider_uid { nil }

    trait :with_google_oauth do
      provider { "google" }
      provider_uid { "1234567890" }
    end
  end
end
