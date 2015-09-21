require_dependency "hightower/application_controller"

module Hightower
  class UsersController < ApplicationController
    def index
      @users = UsersFilter.new(Hightower.user_class.all).perform(params)
    end

    def show
      @dashboard = UserDashboard.new(params)
    end
  end
end
