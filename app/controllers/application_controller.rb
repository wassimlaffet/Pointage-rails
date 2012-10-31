class ApplicationController < ActionController::Base
  class Action < ApplicationController
    include FocusedController::Mixin

    respond_to :json

    before_filter {request.format = :json}
  end
  
end