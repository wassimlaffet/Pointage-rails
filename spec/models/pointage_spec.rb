require 'spec_helper'

describe PointagesController do
 # pending "add some examples to (or delete) #{__FILE__}"
   include ApiRequest
    
  describe PointagesController::Create do
     it "should create new pointage" do
    get
    expect(response).to be_success
    end
  end
  
   describe PointagesController::Update do
     it "should update pointage" do
    get type: "hp"
    expect(response).to be_success
    end
  end
     
end