require "hightower/engine"

module Hightower
  mattr_accessor :user_class

  class << self
    # Inspired by Forem gem
    def user_class
      if @@user_class.is_a?(Class)
        raise "You can not set Hightower.user_class to be a class. Please use a string instead.\n\n"
      elsif @@user_class.is_a?(String)
        begin
          Object.const_get(@@user_class)
        rescue NameError
          @@user_class.constantize
        end
      end
    end
  end
end
