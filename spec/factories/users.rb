FactoryGirl.define do
  factory :user do
    sequence(:name){|n| "Adam-#{n}"}
    password 'password'
    password_confirmation 'password'
    sequence(:email){ |x| "me-#{x}@example.com" }

    factory :admin do
      admin true
    end
  end
end
