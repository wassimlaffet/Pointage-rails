module DemandesController
  class Action < ApplicationController::Action
    before_filter :authenticate_user!
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