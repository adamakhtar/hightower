module Hightower
  class Persona < ActiveRecord::Base
    belongs_to :user, class_name: Hightower.user_class.name
    belongs_to :segment

    validates :user_id, :segment_id, presence: true

    scope :unprocessed, -> { where(processed: false) }
    scope :unprocessed, -> { where(processed: false) }
    scope :unprocessed_first, -> { order(:processed) }
    scope :newest_first, -> { order(:created_at) }

    def user_label
      user.send(Hightower.user_label_method.to_sym)
    end
  end
end
