require File.dirname(__FILE__) + '/../spec_helper'
  
  describe V1::PointagesApi do
   # pending "add some examples to (or delete) #{__FILE__}"
   include Raisin::FunctionalTest
     include ApiRequest
      
    describe V1::PointagesApi::New do
       it "should create new pointage" do
      get :new
      
           puts "Created : #{response.body}"
      expect(response).to be_success
      end
    end
    
     describe V1::PointagesApi::Update do
       it "should update pointage" do
      get :update, type: "hr"
      
           puts "Updated : #{response.body}"
      expect(response).to be_success
      end
    end
       
  end