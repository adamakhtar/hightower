module Hightower
  module Behaviour 
    extend ActiveSupport::Concern 
    class_methods do
      def respond(users)
        new.respond(users)
      end

      def observe
        new.observe
      end
      
      def human_name
        name.demodulize.underscore.humanize.downcase
      end
    end

  end
end