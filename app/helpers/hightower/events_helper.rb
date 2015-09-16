module Hightower
  module EventsHelper
    def title_for_current_filter(filter)
      if filter.current_action 
        filter.current_action + " events"
      else
        t('hightower.events.all_title')
      end
    end
  end
end