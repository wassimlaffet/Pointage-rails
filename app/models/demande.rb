class Demande
  include Mongoid::Document
  
  embedded_in :user
  
  field :dc,  as: :date_creation,    type: DateTime
  field :dd,  as: :date_depart,    type: DateTime
  field :hr,  as: :date_retour,    type: DateTime
  field :validee,  as: :validee,  type: Boolean, default: false
  
  def self.for_type(type)
    Demandes.const_get(type.classify)
  end
end