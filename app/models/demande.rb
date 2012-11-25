class Demande
  include Mongoid::Document
  
  embedded_in :user
  
  field :dc,  as: :date_creation,    type: DateTime
  field :dd,  as: :date_depart,    type: DateTime
  field :dr,  as: :date_retour,    type: DateTime
  field :val,  as: :validee,  type: Boolean, default: false
  
  scope :not_valides, where(:validee => false).order_by(:date_creation => :desc)
  
  def self.for_type(type)
    Demandes.const_get(type.classify)
  end
  
  def initialize(attrs = nil, options = nil)
    super
    puts "********************** test"
  end
  
  def valider
    self.validee = true
    save
  end
end