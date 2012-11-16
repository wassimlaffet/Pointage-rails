module Demandes
  class Autorisation < Demande
    
    field :nbh,  as: :nombre_heurs,    type: Float
    field :adr,  as: :adresse,    type: String
    field :tel,  as: :telephone,  type: String
  end
end