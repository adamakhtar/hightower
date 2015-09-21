module Hightower
  class SegmentsDashboard
    def initialize(params)
      @params = params
    end

    def segments_tabs
      @segments_tabs = TabsList.new(
        collection: segments_with_counts, 
        current: params[:current_segment],
        label_method: :name,
        badge_method: :users_count,
        partial: 'hightower/segments/tab'
      )
    end

    def current_segment
      @current_segment ||= Segment.where(name: @segments_tabs.current).take
    end

    def title
     if current_segment
        current_segment.name 
      else
        I18n.t('hightower.segments.none_title')
      end
    end

    def personas
      @personas ||= if current_segment
        current_segment.personas
      else
        []
      end 
    end

    def paginated_personas
      @paginated_personas ||= personas.page(params[:page]).per(Hightower.per_page)
    end

    private

    attr_reader :params

    def segments_with_counts
      Segment.joins(:personas).
              select('hightower_segments.name, hightower_segments.id, count(hightower_personas.segment_id) as users_count').
              group('hightower_segments.id').
              alphabetical
    end
  end
end