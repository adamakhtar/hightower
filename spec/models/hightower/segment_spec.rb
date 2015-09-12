require 'rails_helper'

module Hightower
  RSpec.describe Segment, type: :model do
    it "does not add duplicate users" do
      segment = create(:segment)
      user = create(:user)

      segment.add_users(user)
      segment.add_users(user)
      
      expect(segment.users).to eq [user]
    end
  end
end