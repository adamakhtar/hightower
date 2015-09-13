require_dependency "hightower/application_controller"

module Hightower
  class SegmentsController < ApplicationController
    def index
      @filter = SegmentsFilter.new(current_segment_id: params[:current_segment_id])
    end
  end
end
