module Hightower
  class Segment < ActiveRecord::Base
    has_many :personas
      
    validates :name, presence: true

    def add_users(users)
      self.users << (Array(users) - self.users)
    end
  end
end

