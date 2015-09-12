FactoryGirl.define do
  factory :hightower_event, :class => 'Hightower::Event' do
    user
    action "logged in"
  end
end
