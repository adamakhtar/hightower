module Hightower 
  class Track
    def initialize(behaviour)
      @behaviour = behaviour
    end

    def self.perform(behaviour)
      new(behaviour).perform
    end

    def perform
      segment = find_or_create_segment(behaviour)
      users = behaviour.observe
      segment.add_users(users)
      users
    end

    private

    attr_reader :behaviour

    def find_or_create_segment(behaviour)
      Segment.where(name: behaviour.name).first_or_create
    end
  end
end