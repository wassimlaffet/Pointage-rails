module UsersController
  class Action < ApplicationController::Action
  #before_filter :authenticate_user!
  end

  class Singular < Action
    expose(:user) { User.where(:id => current_user.id) }
  end

  class Index < Action
    expose(:users) {
      if !current_user.admin?
        User.where(:id => current_user.id)
      else
        User.all
      end
    }
  end

  class UpdateSoldeUsers < Index
    def call
      users = params[:users]
      updatedUsers = Array.new()
      users.each do |user|
        if !user[:id].nil?
          current = User.find(user[:id])
          current.update_attribute(:sc,user[:sc]) if !user[:sc].nil?
          current.update_attribute(:sr,user[:sr]) if !user[:sr].nil?
          current.update_attribute(:admin,user[:admin]) if !user[:admin].nil?
        updatedUsers << current
        end
      end
      respond_with(updatedUsers,location: users_url)
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