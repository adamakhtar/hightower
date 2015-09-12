module Hightower
  module Behaviour
    def self.respond
      new.respond
    end

    def self.observe
      new.observe
    end

    def human_name
      self.class.name.demodulize.underscore.humanize.downcase
    end
  end
end