require 'spec_helper'

    describe UsersController do
   # pending "add some examples to (or delete) #{__FILE__}"
     include ApiRequest
      
      describe UsersController::Index do
        it "should test index response" do
         get
         expect(response.status).to eql 200
         expect(json_response).to be_has_key 'users'
        end     
      end
     
      describe UsersController::Updatesoldeusers do
       let(:users){{users:[{id: "50922d7d85d9747b0c000001",sr: 70,sc: 50}]}}
       it "is a good user" do   
        post users
        expect(response).to be_success
        expect(json_response).to_not be_empty
       end     
     end
     
     describe UsersController::Destroy do
      it "User is deleting" do
       get id: '50aa4fd485d9743f11000001'
       puts response.body
       expect(response.status).to eql 200  
      end
     end
    
end
