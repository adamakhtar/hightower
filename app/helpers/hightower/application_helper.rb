module Hightower
  module ApplicationHelper
    def persona_processed_status(persona)
      if persona.processed 
        t('hightower.segments.processed_label') 
      else
        t('hightower.segments.unprocessed_label') 
      end
    end
  end
end
