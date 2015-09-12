require 'rails_helper'

module Hightower
  RSpec.describe Engage, type: :model do
    describe "#perform" do
      it "engages unprocessed users with given response to their behaviour" do
        user = stub_user
        behaviour = stub_behaviour
        segment = stub_segment_with(user, behaviour)
        allow(Segment).to receive(:for).with(behaviour).and_return(segment)

        Engage.perform(behaviour)

        expect(behaviour).to have_received(:respond).with([user])
        expect(segment).to have_received(:unprocessed_users)
        expect(segment).to have_received(:mark_as_processed)
      end

      def stub_behaviour
        behaviour = double(:behaviour, name: 'slipping away users', respond: true)
      end

      def stub_user
        user = build_stubbed(:user)
      end

      def stub_segment_with(users, behaviour)
        users = Array(users)
        segment = build_stubbed(:segment, name: behaviour.name)
        allow(segment).to receive(:unprocessed_users).and_return(users)
        allow(segment).to receive(:mark_as_processed)
        segment
      end
    end
  end
end