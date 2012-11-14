module Demandes
  class Conge < Demande
    
    field :nbj,  as: :nombre_jours,    type: Float
    field :adr,  as: :adresse,    type: String
    field :tel,  as: :telephone,  type: String
    field :tp,  as: :type_conge,  type: String
  
    def valider
      
      super
      
      @user = self.user
      if self.type_conge == "recup"
        if user.solde_recup > self.nombre_jours
          user.solde_recup -= self.nombre_jours
        else
          user.solde_conge -= (self.nombre_jours - user.solde_recup) 
          user.solde_recup = 0
        end
        
        user.save
      elsif self.type_conge == "conge_paye"
        if user.solde_conge > self.nombre_jours
          user.solde_conge -= self.nombre_jours
        else
          user.solde_recup -= (self.nombre_jours - user.solde_conge)
          user.solde_conge = 0
        end
        
        user.save
      end
    end
  end
end