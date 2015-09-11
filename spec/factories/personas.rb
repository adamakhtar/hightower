FactoryGirl.define do
  factory :persona, :class => 'Hightower::Persona' do
    user
    segment
    engaged false

    trait :processed do 
      engaged true
    end
  end
end
