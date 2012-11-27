require File.dirname(__FILE__) + '/../spec_helper'

describe Demande do
  it "should be valide" do
    demande = Demande.new
    user = User.new
    user.save
    demande.user = user
    demande.valider
    user.demandes.last.should_not be_validee
    puts "************** OK"
  end
end
