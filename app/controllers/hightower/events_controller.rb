require_dependency "hightower/application_controller"

module Hightower
  class EventsController < ApplicationController
    def index
      @filter = EventsFilter.new(Event.all, params[:current_action])
    end
  end
end
