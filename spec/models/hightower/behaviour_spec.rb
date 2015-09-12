require 'rails_helper'

module Hightower
  RSpec.describe Behaviour do

    class SlippingAwayUsers 
      include Behaviour
    end

    def fake_behaviour
      SlippingAwayUsers.new
    end

    it "returns it's name with spaces" do
      behaviour = fake_behaviour
      expect(behaviour.human_name).to eq 'slipping away users'
    end
  end
end