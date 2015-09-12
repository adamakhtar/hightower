module Hightower
  class Engage
    def initialize(behaviour)
      @behaviour = behaviour
    end

    def self.perform(behaviour)
      new(behaviour).perform
    end

    def perform
      return unless segment = find_segment(behaviour)

      users = segment.unprocessed_users

      if behaviour.respond(users)
        segment.mark_as_processed
        users
      else
        false
      end
    end

    private

    attr_reader :behaviour

    def find_segment(behaviour)
      Segment.for(behaviour)
    end
  end
end