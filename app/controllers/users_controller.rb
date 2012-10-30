
module UsersController
  class Action < ApplicationController::Action
    puts ":authenticate_user!"
    before_filter :authenticate_user!
  end

  class Singular < Action
    expose(:user) { User.find(params[:id]) }
  end

  class Index < Action
    puts "Index"
    expose(:users) { User.all }
    #Resque.enqueue(TestJob, 0)
  end
  
  class Create < Action
    puts "Create"
    expose(:user)

    def call
      puts "called in post count = #{User.count}"
      @user = User.new(params[:user])
      user.save
      respond_with(user, location: users_url)
      #redirect_to users_url
    end
  end  
  
  class Destroy < Singular
    def call         
     if !user.destroy   
       flash[:error] = "Could not delete user"
        respond_with("can not delete this user !!!!!!!!!!!!!!!!!",location: users_url)   
     else
        respond_with(user,location: users_url)   
     end
    end
  end
  
end