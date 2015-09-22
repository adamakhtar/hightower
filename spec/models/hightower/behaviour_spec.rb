require 'rails_helper'

module Hightower
  RSpec.describe Behaviour do

    class SlippingAwayUsers 
      include Behaviour
    end

    it "returns it's name with spaces" do
      expect(SlippingAwayUsers.human_name).to eq 'slipping away users'
    end
  end
end