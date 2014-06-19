FactoryGirl.define do
  factory :user do
    sequence(:full_name) { |n| "Testuser #{n}" }
    sequence(:email) { |n| "testuser#{n}@example.com" }
    password "password"
    password_confirmation "password"
    phone "+0412345678"
    birthday "07/11/1988"
    admin false

    factory :confirmed_user do
      confirmed_at Date.today

      factory :admin do
        admin true
      end
    end
  end
end