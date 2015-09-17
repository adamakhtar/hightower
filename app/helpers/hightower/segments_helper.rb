module Hightower
  module SegmentsHelper
    def segment_dom_class(filter, segment)
      "active" if filter.current_segment?(segment)
    end
  end
end
