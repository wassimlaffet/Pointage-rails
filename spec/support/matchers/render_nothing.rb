RSpec::Matchers.define :render_nothing do
  match do |response|
    response.body.blank?
  end

  failure_message_for_should do |response|
    "Expected response to render nothing but got #{response.body}"
  end
end