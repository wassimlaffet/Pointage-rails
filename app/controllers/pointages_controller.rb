module PointagesController
  class Action < ApplicationController::Action
    before_filter :authenticate_user!
  end

  class Index < Action
    expose(:pointages) { Pointage.where(:user_id => current_user.id)}
  end
  
  class Create < Action
    expose(:pointage)

    def call
      @pointage= Pointage.new(params[:pointage])

      pointage.save
      #respond_with(user, location: users_url)
      redirect_to pointages_url
    end
  end  
end