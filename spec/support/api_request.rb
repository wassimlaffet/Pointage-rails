module ApiRequest
  extend ActiveSupport::Concern

  included do
    include RSpec::Rails::ControllerExampleGroup
    metadata[:type] = :api

    render_views

     let(:current_user) { User.first }

    before do
       login_as current_user
      request.env['Content-Type'] = Mime::JSON
      request.env['HTTP_ACCEPT']  = Mime::JSON
    end
  end
  
  def login_as user
    request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in :user, user
  end

  def json_response
    @json_response ||= MultiJson.decode(response.body)
  end
end