module Hightower
  class SegmentsFilter

    class NillSegment 
      include AbstractController::Translation
      def name 
        t('hightower.segments.none_title')
      end

      def personas
        []
      end
    end

    def initialize(current_segment_id:)
      @current_segment_id = current_segment_id
    end

    def current_segment
      @current_segment ||= if current_segment_id 
        Segment.where(id: @current_segment_id).take 
      elsif Segment.count > 0
        Segment.alphabetical.first
      else
        NillSegment.new
      end
    end

    def no_results?
      current_segment_personas.none?
    end

    def segments
      Segment.all.alphabetical
    end

    def current_segment_personas
      @current_segment_personas ||= current_segment.personas
    end

    private

    attr_reader :current_segment_id
  end
end