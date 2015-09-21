module Hightower
  class UserDashboard

    def initialize(params)
      @params = params
    end

    def events_tabs
      @events_tabs = TabsList.new(
        collection: user_events_with_counts, 
        current: params[:current_event],
        label_method: :first,
        badge_method: :last,
        partial: 'hightower/users/event_tab'
      )
    end

    def paginated_events
      @paginated_events ||= events.page(params[:page]).per(Hightower.per_page)
    end

    def segments
      @segments ||= Segment.joins(:personas).where('hightower_personas.user_id = ? ', user.id).alphabetical
    end
    
    def title
      user.send(Hightower.user_label_method)
    end

    def user
      @user ||= User.find(params[:id])
    end

    protected

    def events  
      @events ||= if events_tabs.current?('all')
        all_user_events
      else
        all_user_events.where(user: user, action: events_tabs.current)
      end
    end

    def all_user_events
      Event.where(user: user)
    end


    def user_events_with_counts
      @events_with_counts ||= {'all' => all_user_events.count}.merge(all_user_events.select('action').group('action').count('user_id')).to_a
    end

    attr_reader :params

  end
end