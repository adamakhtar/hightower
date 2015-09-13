module Hightower
  class SegmentsFilter
    def initialize(current_segment_id:)
      @current_segment_id = current_segment_id || Segment.alphabetical.first.id
    end

    def current_segment
      @current_segment ||= Segment.where(id: @current_segment_id).take 
    end

    def segments
      Segment.all.alphabetical
    end

    def current_segment_personas
      @current_segment_personas ||= begin 
        if current_segment.present?
          current_segment.personas
        else
          []      
        end
      end
    end
  end
end