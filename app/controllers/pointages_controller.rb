module PointagesController
  class Action < ApplicationController::Action

    include ApplicationHelper::Status
    before_filter :authenticate_user!
    def calculDuree (point, param)
      if(param == VALUE_MAP[ HEURE_PAUSE])
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

  class Index < Action
    expose(:pointages) {
      if !current_user.admin?
        Pointage.where(:user_id => current_user.id).order_by(:heure_start => :desc)
      else
        Pointage.all.order_by(:heure_start => :desc)
      end
    }
  end

  class Findallpointagebyuser < Index
    expose(:all_pointages){Array.new}

    def call
      if(params[:mail].nil?)
        @all_pointages = pointages.all.to_a
      else
        pointages.each do |point|
          all_pointages << point if point.user.email == params[:mail]
        end
      end
    end
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

  class Create < Singular
    expose(:pointage_exist){pointages.where(:heure_start.gte => Date.today)}

    def call
      if pointage_exist.count > 0
        respond_with("Pointage already exist !!!!!!",location: pointages_url)
      else
        pointage = Pointage.new()
        pointage.user_id = current_user.id
        current_DateTime = DateTime.now
        pointage.heure_start = current_DateTime
        pointage.heure_pause = current_DateTime
        pointage.heure_reprise = current_DateTime
        pointage.heure_end = current_DateTime
        pointage.save
        respond_with(pointage,location:pointages_url)
      end
    end
  end

  class Update < Singular
    expose(:point) {pointages.where(:heure_start.gte => Date.today).last}

    def call
      if(!point.nil?)
        point.update_attribute(params[:type], DateTime.now)
        duree = calculDuree(point,params[:type])
        point.update_attribute(:dr, duree)
        point.save
        respond_with(point)
      else
        respond_with("warning : pas de pointage", location:pointages_url)
      end

    end
  end

end