require 'rails_helper'

module Hightower
  RSpec.describe Event, type: :model do
    it "creates event" do
      event = Event.create(user_id: 1, action: 'logged in', meta: {message: 'hey'})

      expect(event).to be_persisted
      expect(event.meta[:message]).to eq 'hey'
      expect(event.action).to eq 'logged in'
    end
  end
end
