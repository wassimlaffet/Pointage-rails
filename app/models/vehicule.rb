class Vehicule
  include Mongoid::Document
  
  embedded_in :user
end