require File.dirname(__FILE__) + '/../spec_helper'

describe V1::UsersApi do
# pending "add some examples to (or delete) #{__FILE__}"
 include Raisin::FunctionalTest
  include ApiRequest
    
    describe V1::UsersApi::Index do
      it "should test index response" do
        get :index
         puts "index : #{response.body}"
        expect(response.status).to eql 200
        expect(json_response).to be_has_key 'users'
      end
    end

   describe V1::UsersApi::Updateusers do
    let(:users){{users:[{id: '50b4e08685d9746871000003',soldeConge: 70,soldeRecup: 50}]}}
    it "is a good user" do
     post :updateusers, users
      puts "update : #{response.body}"
     expect(response).to be_success
     expect(json_response).to_not be_empty
    end
  end

    describe V1::UsersApi::Deleteuser do
     it "User is deleting" do
      delete :deleteuser, id: '111111111111'
      puts "delete : #{response.body}"
      expect(response.status).to eql 200
     end
    end

end
