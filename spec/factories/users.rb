FactoryGirl.define do
  factory :user do
    sequence(:name){|n| "Adam-#{n}"}
  end
end
