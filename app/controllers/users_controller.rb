
module UsersController
  class Action < ApplicationController::Action
    #before_filter :authenticate_user!
  end

  class Index < Action
    expose(:users) { User.all }
    puts "yyyyyy"
     Resque.enqueue(TestJob, 0)
  end
  
  class Create < Action
    expose(:user)

    def call
      puts "called in post count = #{User.count}"
      @user = User.new(params[:user])
      user.save
      respond_with(user, location: users_url)
      #redirect_to users_url
    end
  end  
end