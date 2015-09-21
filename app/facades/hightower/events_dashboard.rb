module Hightower
  class EventsDashboard

    def initialize(params)
      @params = params
    end

    def events_tabs
      @events_tabs = TabsList.new(
        collection: events_with_counts, 
        current: params[:current_event],
        label_method: :first,
        badge_method: :last,
        partial: 'hightower/events/tab'
      )
    end

    def paginated_events
      @paginated_events ||= events.page(params[:page]).per(Hightower.per_page)
    end

    def title
      if events_tabs.current
        events_tabs.current
      else
        I18n.t('hightower.events.none_title')
      end
    end

    protected

    def events  
      @events ||= if events_tabs.current?('all')
        Event.all
      else
        Event.where(action: events_tabs.current) 
      end
    end

    def events_with_counts
      @events_with_counts ||= {'all' => Event.count}.merge(Event.select('action').group('action').count('user_id')).to_a
    end

    attr_reader :params

  end
end