require_dependency "hightower/application_controller"

module Hightower
  class UsersController < ApplicationController
    def index
      @users = UsersFilter.new(Hightower.user_class.all).perform(params)
    end

    def show
      @user = User.find(params[:id])
      @segments = Segment.joins(:personas).where('hightower_personas.user_id = ? ', @user.id).alphabetical
      @events = Event.where(user: @user).newest_first
      @filter = EventsFilter.new(@events, params[:current_action])
    end
  end
end
