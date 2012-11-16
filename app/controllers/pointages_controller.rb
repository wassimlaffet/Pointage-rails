module PointagesController
  class Action < ApplicationController::Action
    
    include ApplicationHelper::Status
    #before_filter :authenticate_user!

    def calculDuree (point, param)
      if(param == VALUE_MAP[HEURE_PAUSE])
      duree = point.hp.to_time - point.hs.to_time
      elsif(param == VALUE_MAP[HEURE_END])
      duree = point.dr + (point.he.to_time - point.hr.to_time)
      else
      duree = point.dr
      end
      return duree
    end

  end

  class Singular < Action
    expose(:pointages) {Pointage.where(:user_id => current_user.id)}
  end

  class Index < Singular
    expose(:pointages) {
      if !current_user.admin?
        Pointage.where(:user_id => current_user.id)
      else
        Pointage.all
      end
    }
  end

  class Findallpointagebyuser < Index
    expose(:all_pointages){
      pointages.all
    }
  end

  class Findpointagebetween < Index
    expose(:between_pointages){
      if !(params[:inf]).nil? && !(params[:sup]).nil?
        pointages.between(:heure_start => Date.parse(params[:inf]) .. Date.parse(params[:sup])+1)
      elsif !(params[:sup]).nil?
        pointages.where(:heure_start.gte => Date.parse(params[:sup])+1)
      elsif !(params[:inf]).nil?
        pointages.where(:heure_start.lte => Date.parse(params[:inf]))
      end
    }
  end

  class Create < Index
    expose(:pointage_exist){pointages.where(:heure_start.gt => Date.today)}

    def call
      if pointage_exist.count > 0
        respond_with("Pointage already exist !!!!!!!!!!!!!!!!!",location: pointages_url)
      else
        pointage = Pointage.new()
        pointage.user_id = current_user.id
        current_DateTime = DateTime.now
        pointage.heure_start = current_DateTime
        pointage.heure_pause = current_DateTime
        pointage.heure_reprise = current_DateTime
        pointage.heure_end = current_DateTime
        pointage.save
        respond_with(pointage)
      end
    end
  end

  class Update < Singular
    expose(:point) {pointages.last}

    def call
      point.update_attribute(params[:type], DateTime.now)
      duree = calculDuree(point,params[:type])
      point.update_attribute(:dr, duree)
      point.save
      respond_with(point)
    end
  end

end