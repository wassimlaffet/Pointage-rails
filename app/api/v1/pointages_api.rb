module V1
  class PointagesApi < Raisin::API
    include ApplicationHelper::Status

    get '/', as: "index" do
      expose(:pointages) {
        if !current_user.admin?
          Pointage.where(:user_id => current_user.id).order_by(:heure_start => :desc)
        else
          Pointage.all.order_by(:heure_start => :desc)
        end
      }
    # response do
    #   render json: pointages
    # end
    end

    get '/findbyuser', as: "findbyuser" do
      expose(:all_pointages){Array.new}

      response do
        if(current_user.admin? && (params[:mail].nil? || params[:mail].empty?))
          puts "*********************#{Pointage.all.to_a}"
          @all_pointages = Pointage.all.to_a
        elsif(current_user.admin? && (!params[:mail].nil? || !params[:mail].blank?))
          Pointage.all.each do |point|
            all_pointages << point if point.user.email == params[:mail]
          end
        else
          @all_pointages = Pointage.where(:user_id => current_user.id)
        end
      #render json: all_pointages
      end
    end

    get '/findbetween', as: "findbetween" do
      expose(:between_pointages){
        if !(params[:inf]).nil? && !(params[:sup]).nil?
          current_user.admin? ? Pointage.between(:heure_start => Date.parse(params[:inf]) .. Date.parse(params[:sup])+1) : Pointage.where(:user_id => current_user.id).between(:heure_start => Date.parse(params[:inf]) .. Date.parse(params[:sup])+1)
        elsif !(params[:sup]).nil?
          current_user.admin? ? Pointage.where(:heure_start.gte => Date.parse(params[:sup])+1) : Pointage.where(:user_id => current_user.id).where(:heure_start.gte => Date.parse(params[:sup])+1)
        elsif !(params[:inf]).nil?
          current_user.admin? ? Pointage.where(:heure_start.lte => Date.parse(params[:inf])) : Pointage.where(:user_id => current_user.id).where(:heure_start.lte => Date.parse(params[:inf]))
        end
      }
    end

    get '/update', as: "update" do
      expose(:updated_pointage)
      response do
        current_pointage = Pointage.where(:user_id => current_user.id).where(:heure_start.gte => Date.today).last
        if(!current_pointage.nil?)
          current_pointage.update_attribute(params[:type], DateTime.now)
          duree = calculDuree(current_pointage,params[:type])
          current_pointage.update_attribute(:dr, duree)
          @updated_pointage = current_pointage
        current_pointage.save
        #render json: point
        else
          render json: "warning : pas de pointage"
        end
      end

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

    get '/create', as: "new" do
      expose(:new_pointage)

      response do
        if Pointage.where(:user_id => current_user.id).where(:heure_start.gte => Date.today).count > 0          
          render json: "Pointage already exist !!!!!!"
        else
          pointage = Pointage.new()
          pointage.user_id = current_user.id
          current_DateTime = DateTime.now
          pointage.heure_start = current_DateTime
          pointage.heure_pause = current_DateTime
          pointage.heure_reprise = current_DateTime
          pointage.heure_end = current_DateTime
          @new_pointage = pointage
        pointage.save
        #render json: pointage
        end
      end
    end

  end
end