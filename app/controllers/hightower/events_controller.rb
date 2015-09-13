require_dependency "hightower/application_controller"

module Hightower
  class EventsController < ApplicationController
    def index
      @events = Event.newest_first
    end
  end
end
