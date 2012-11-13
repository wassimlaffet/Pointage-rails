module Demandes
  class Conge < Demande
    
    field :nbj,  as: :nombre_jours,    type: Float
    field :adr,  as: :adresse,    type: String
    field :tel,  as: :telephone,  type: String
    field :tp,  as: :type_conge,  type: String
  end
end