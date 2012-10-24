RSpec::Matchers.define :have_keys do |array|
  chain :with_root do |key|
    @root = key
  end

  match do |response|
    if @root && !response.key?(@root)
      false
    else
      value = @root ? response[@root] : response
      value = value.first if value.is_a?(Array)

      @missing = array.detect { |k| !value.key?(k) }
      @missing === nil
    end
  end

  failure_message_for_should do |response|
    if @missing
      "Expected response #{response.inspect} to include #{@missing}"
    else
      "Expected response #{response.inspect} to have '#{@root}' as root"
    end
  end
end

RSpec::Matchers.define :have_keys_with_values do |hash|
  match do |response|
    @missing = hash.detect { |k, v| !(response[k] == v) }
    @missing === nil
  end

  failure_message_for_should do |response|
    if response.has_key?(@missing.first)
      "expected #{@missing.first} to be #{@missing.last} but got #{response[@missing.first]}"
    else
      "Expected response #{response.inspect} to include #{@missing.first}"
    end
  end
end