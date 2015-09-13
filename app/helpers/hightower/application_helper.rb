module Hightower
  module ApplicationHelper
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
