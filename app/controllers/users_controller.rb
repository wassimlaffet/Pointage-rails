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
  end

  class Create < ApplicationController::Action
    expose(:user)
    def call   
      @user = User.new(params[:user])
      user.name = @user.email.split("@")[0]
      puts user
      user.save
      respond_with(user, location: users_url)
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