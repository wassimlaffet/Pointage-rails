module UsersController
  class Action < ApplicationController::Action
    puts ":authenticate_user!"
    before_filter :authenticate_user!
  end

  class Singular < Action
    expose(:user) { User.where(:id => current_user.id) }
  end

  class Index < Singular
    expose(:users) { user}
  #Resque.enqueue(TestJob, 0)
  end

  class Create < Action
    puts "Create"
    expose(:user)
    def call
      puts "called in post count = #{User.count}"
      @user = User.new(params[:user])
      user.name = @user.email.split("@")[0]
      puts user
      user.save
      respond_with(user, location: users_url)
    #redirect_to users_url
    end
  end

  class Destroy < Action
    expose(:user_del){User.where(:id => params[:id]).first}

    def call
      if !user_del.destroy
        respond_with("can not delete this user !!!!!!!!!!!!!!!!!",location: users_url)
      else
        respond_with("user_del okiii",location: users_url)
      end
    end
  end

end