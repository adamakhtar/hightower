module Hightower
  class TabsList
    attr_reader :current 

    def initialize(collection:, current:, label_method:, partial:, badge_method: nil)
      @collection = collection
      @label_method = label_method
      @badge_method = badge_method
      @current = set_current(current)
      @partial = partial
    end

    def tabs
      @tabs ||= @collection.map do |item|
        Tab.new(
          label: item.send(@label_method),
          badge: item.send(@badge_method),
          active: current?(item.send(@label_method)),
          partial: @partial
        )
      end
    end

    def current?(label)
      @current == label
    end

    def set_current(current)
      if current
        current
      elsif @collection.any?
        @collection[0].send(@label_method)
      else
        nil
      end
    end
  end
end