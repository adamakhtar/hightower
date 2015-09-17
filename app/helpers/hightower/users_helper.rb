module Hightower
  module UsersHelper
    def event_dom_class(filter, action=nil)
      "active" if filter.current_action?(action)
    end
  end
end
