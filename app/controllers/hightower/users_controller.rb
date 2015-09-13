require_dependency "hightower/application_controller"

module Hightower
  class UsersController < ApplicationController
    def index
      @users = Hightower.user_class.all
    end
  end
end
