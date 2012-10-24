require 'spec_helper'

describe UsersController do
 # pending "add some examples to (or delete) #{__FILE__}"
   include ApiRequest
    
   describe UsersController::Index do
     it "should test index response" do
       
      get
      expect(response).to be_success
      expect(json_response).to be_has_key 'users'
       
     end     
   end
   
    describe UsersController::Create do
     
     let(:user_params) { { user: { email: " laffetwassim@gmailzlmmml.com", password: "aaaaaaaaaaaaa", password_confirmation: "aaaaaaaaaaaaa" } } }
     
     it "is a good user" do     
      post user_params   
      
      puts response.body
      expect(response.status).to eql 201
      #expect(json_response).to be_has_key 'users'
       
     end     
   end
   
  
end
