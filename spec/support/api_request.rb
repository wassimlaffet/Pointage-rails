module ApiRequest
  extend ActiveSupport::Concern

  included do
    metadata[:type] = :api

    render_views

    let(:current_user) { User.first}

    before do
      login_as current_user
      request.env['Content-Type'] = Mime::JSON
      request.env['HTTP_ACCEPT']  = Mime::JSON
    end
  end

  def json_response
    @json_response ||= MultiJson.decode(response.body)
  end
end