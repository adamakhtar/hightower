require_dependency "hightower/application_controller"

module Hightower
  class EventsController < ApplicationController
    def index
      @dashboard = EventsDashboard.new(params)
    end
  end
end
