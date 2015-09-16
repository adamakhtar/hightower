module Hightower
  class EventsFilter

    attr_reader :current_action, :scope
    
    def initialize(scope, current_action)
      @scope = scope
      @current_action = current_action
    end

    def events_with_counts
      scope.group('action').count('user_id')
    end

    def events  
      if current_action.present?
        scope.where(action: current_action) 
      else
        scope
      end
    end
  end
end