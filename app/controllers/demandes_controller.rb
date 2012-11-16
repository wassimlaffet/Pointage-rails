module DemandesController
  class Action < ApplicationController::Action
    #before_filter :authenticate_user!
  end

  class Index < Action
    expose(:demandes) {
      if !current_user.admin?
        current_user.demandes
      else
        Demande.all
      end
    }
  end

  class ShowByDates < Index
    expose(:demandes_Between){
      if !(params[:inf]).nil? && !(params[:sup]).nil?
        demandes.between(params[:type].to_sym => Date.parse(params[:inf]) .. Date.parse(params[:sup])+1)
      elsif !(params[:sup]).nil?
        demandes.where((params[:type].to_sym).gte => Date.parse(params[:sup])+1)
      elsif !(params[:inf]).nil?
        demandes.where((params[:type].to_sym).lte => Date.parse(params[:inf]))
      end
    }

    def call
      puts "++++++++++++++++++#{demandes_Between.count}"
       respond_with("coooool", location: demandes_url)
    end
  end

  class Create < Action
    expose(:demande)
    def call
      puts "*********************type: #{params[:type]}"
      puts "*********************demande: #{params[:demande]}"
      @demande = Demande.for_type(params[:type]).new(params[:demande])

      if demande.valid?
        demande.date_creation = DateTime.now
        demande.user = current_user
        demande.save(validate: false)
        puts "********************* create demande OK"
      end

      respond_with(demande, location: demandes_url)
    end
  end
end