require_dependency "hightower/application_controller"
module Hightower
  class SegmentsController < ApplicationController
    def index    
      @dashboard = SegmentsDashboard.new(params)
    end
  end
end
