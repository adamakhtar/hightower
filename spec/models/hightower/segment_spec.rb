require 'rails_helper'

module Hightower
  RSpec.describe Segment, type: :model do
    it "does not add duplicate users" do
      segment = create(:segment)
      user = create(:user)

      segment.users << user
      segment.users << user

      expect(segment.users).to eq [user]
    end
  end
end