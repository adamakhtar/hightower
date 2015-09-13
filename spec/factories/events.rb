FactoryGirl.define do
  factory :event, :class => 'Hightower::Event' do
    user
    action "logged in"
  end
end
