class Pointage
  include Mongoid::Document
  
  belongs_to :user
  
  field :hs,  as: :heure_start,    type: DateTime
  field :hp,  as: :heure_pause,    type: DateTime
  field :hr,  as: :heure_reprise,  type: DateTime
  field :he,  as: :heure_end,      type: DateTime  
  field :dr,  as: :duree,          type: Float,  default: 0
end