module PointagesController
  class Action < ApplicationController::Action
    before_filter :authenticate_user!
    def format_pointage(pointages)
      tab = Array.new()
      pointages.each do |point|
        @pointage= Hash.new()
        @pointage["point"] = point
        @pointage["user"] = point.user
        tab << @pointage
      end
      return tab
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
    expose(:all_pointages){pointages.all}

    def call
      @result = format_pointage(all_pointages)
      respond_with(@result,location: pointages_url)
    end
    
  end

  class Findlastpointage < Singular
    expose(:last_pointages){pointages.last}

    def call
      #Resque.enqueue(TestJob)
      respond_with(last_pointages,location: pointages_url)
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

    def call
        @result = format_pointage(between_pointages)
      respond_with(@result,location: pointages_url)
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