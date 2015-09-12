module Hightower
  class Persona < ActiveRecord::Base
    belongs_to :user, class_name: Hightower.user_class.name
    belongs_to :segment

    validates :user_id, :segment_id, presence: true

    scope :unprocessed, -> { where(processed: false) }
  end
end
