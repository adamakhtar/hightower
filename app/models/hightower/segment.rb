module Hightower
  class Segment < ActiveRecord::Base
    has_many :personas
    has_many :users, through: :personas do
      def << (users)
        super( Array(users) - proxy_association.owner.users )
      end
    end
      
    validates :name, presence: true
  end
end

