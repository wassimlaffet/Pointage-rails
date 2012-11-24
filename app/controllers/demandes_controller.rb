module DemandesController
  class Action < ApplicationController::Action
    before_filter :authenticate_user!
  end
 
  class Index < Action
    expose(:demandes)
    
    def call
      if !current_user.admin?
        @demandes = current_user.demandes.order_by(:date_creation => :desc)
      else
        @demandes = Array.new
        User.all.each do |user|
          user.demandes.not_valides.each do |demande|
            @demandes << demande            
          end
        end
      end
    end
  end
 
  class ByDate < Action
    expose(:demandes)    

    def call
      @demandes = Array.new
      puts "******************** date_inf: #{DateTime.parse(params[:date_inf])}   date_sup #{DateTime.parse(params[:date_sup])}"
      if current_user.admin && params[:date_inf] && params[:date_sup]
        User.all.each do |user|
          
          user.demandes.between(date_depart: Date.parse(params[:date_inf]) .. Date.parse(params[:date_sup])).each do |demande|

            @demandes << demande
          end
        end
      end      
    end
  end

  class Create < Action
    expose(:demande)
    def call
      @demande = Demande.for_type(params[:type]).new(params[:demande])

      if demande.valid?
        demande.date_creation = DateTime.now
        demande.user = current_user
        demande.save(validate: false)
      end

      respond_with(demande, location: demandes_url)
    end
  end

  class Valider < Action
    def call
      if params[:demandes]
        params[:demandes].each do |demande|
          user = User.where(_id: demande["user_id"]).first
          if user
            dem = user.demandes.where(_id: demande["id"]).first
            if dem
              dem.valider
            end
          end
        end
      end
      
      respond_with("validation ok", location: demandes_url)
    end
  end
end