module UsersController
  class Action < ApplicationController::Action
    before_filter :authenticate_user!
  end

  class Singular < Action
  #expose(:user) { User.where(:id => current_user.id) }
  end

  class Index < Action
    expose(:users) {
      if current_user.admin?
        User.where(:id => current_user.id)
      else
        User.all
      end
    }

    def call
      #respond_with(users,location: users_url)
    end
  end

  class Updatesoldeusers < Index
    expose(:updatedusers)  {Array.new()}

    def call
      users = params[:users]

      users.each do |user|
        if !user[:id].nil?
          current = User.find(user[:id])
          current.update_attribute(:sc,user[:sc]) if !user[:sc].nil?
          current.update_attribute(:sr,user[:sr]) if !user[:sr].nil?
          current.update_attribute(:admin,user[:admin]) if !user[:admin].nil?
          updatedusers << current
        end
      end
    end
  end

  class Destroy < Action
    expose(:user_del){User.where(:id => params[:id]).first}

    def call
      if user_del.nil?
        respond_with("failed : can not find this user",location: users_url)
      elsif !user_del.destroy
        respond_with("failed : can not delete this user",location: users_url)
      else
        respond_with("succed : delete user succed",location: users_url)
      end
    end
  end

end