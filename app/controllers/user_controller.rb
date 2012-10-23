module UsersController
  class Action < ApplicationController::Action
    before_filter :authenticate_user!
  end

  class Index < Action
    expose(:users) { User.all }
  end
  
  class Create < Action
    expose(:user)

    def call
      @user = User.new
    end
  end
  
end