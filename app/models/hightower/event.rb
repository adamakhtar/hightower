module Hightower
  class Event < ActiveRecord::Base
    belongs_to :user, class_name: Hightower.user_class

    validates :user_id, :action, presence: true

    serialize :meta

    scope :newest_first, -> { order(created_at: :desc) }
  end
end
