module PointagesController
  class Action < ApplicationController::Action
    before_filter :authenticate_user!
  end

  class Singular < Action
    expose(:pointages) {Pointage.where(:user_id => current_user.id)}
  end

  class Index < Singular
    expose(:pointages) {Pointage.where(:user_id => current_user.id)}
  end

  class Findallpointagebyuser < Singular
    expose(:all_pointages){pointages.all}
    def call
    respond_with(all_pointages,location: pointages_url)
    end
  end

  class Findlastpointage < Singular
    expose(:last_pointages){pointages.last}
     def call
    respond_with(last_pointages,location: pointages_url)
    end
  end
  
  class Findpointagebetween < Singular
    expose(:between_pointages){pointages.between(:heure_start => Date.parse(params[:inf]) .. Date.parse(params[:sup])+1)}
     def call
    respond_with(between_pointages,location: pointages_url)
    end
  end

  class Create < Singular
    expose(:pointage_exist){pointages.where(:heure_start.gt => Date.today)}

    def call
      if pointage_exist.count > 0
        respond_with("Pointage already exist !!!!!!!!!!!!!!!!!",location: pointages_url)
      else
        pointage = Pointage.new()
        pointage.user_id = current_user.id
        pointage.heure_start = DateTime.now
        pointage.save
        #respond_with(user, location: users_url)
        respond_with(pointage)
      end
    end
  end

  class Update < Singular
    expose(:lst_pointages) {pointages.where(:heure_start.gt => DateTime.now.to_date)}

    def call
      lst_pointages.each do |point|
        point.update_attribute(params[:type], DateTime.now)
        point.save
      end
      respond_with(lst_pointages.all.to_a)
    end

  end

end