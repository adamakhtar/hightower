module Hightower
  module ApplicationHelper

    def nav_link_class(link_name)
      "active" if controller_name == link_name.to_s
    end

    def css_body_classes
      "hightower " +
      "hightower_#{ controller_name } " +
      "hightower_#{ controller_name }_#{ action_name }"
    end

    def persona_processed_status(persona)
      if persona.processed 
        t('hightower.segments.processed_label') 
      else
        t('hightower.segments.unprocessed_label') 
      end
    end

    def user_name(user)
      user.send(Hightower.user_label_method)
    end
  end
end
