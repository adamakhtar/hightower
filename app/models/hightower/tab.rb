module Hightower
  class Tab
    attr_reader :label, :badge
    def initialize(label:, partial:, badge: nil, active: false)
      @label = label
      @badge = badge
      @active = active
      @partial = partial
    end

    def active_class
      "active" if @active
    end

    def to_partial_path
      @partial
    end
  end
end