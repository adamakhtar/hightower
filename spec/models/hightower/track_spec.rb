require 'rails_helper'

module Hightower
  RSpec.describe Track, type: :model do
    describe "#perform" do
      it "creates segment for behaviour if it doesnt exist" do
        user = create(:user)
        behaviour = stub_behaviour(name: 'slipping away users', users: [user])
        
        Track.perform(behaviour)

        expect(Segment.where(name: 'slipping away users').count).to eq 1
      end

      it "adds users who match given behaviour to the segment" do
        user = create(:user)
        segment = create(:segment, name: 'slipping away users')
        behaviour = stub_behaviour( name: 'slipping away users', users: [user])
        
        Track.perform(behaviour)

        expect(segment.users).to eq [user]
        expect(segment.personas.where(user: user, processed: false).count).to eq 1
      end

      def stub_behaviour(name:, users:)
        behaviour = double(:behaviour, human_name: name, observe: users)
      end
    end
  end
end