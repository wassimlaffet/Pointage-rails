RSpec::Matchers.define :require_presence_of do |attr|
  match do |model|
    model.send("#{attr}=", nil)
    !model.valid? && model.errors.has_key?(attr)
  end
end