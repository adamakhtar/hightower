FactoryGirl.define do
  factory :segment, :class => 'Hightower::Segment' do
    sequence(:name){|x| "#{x} slipping away users"}
  end
end
