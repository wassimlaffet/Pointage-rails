RablRails.configure do |c|
    c.use_custom_responder = true
end

Raisin::Base.responder = RablRails::Renderer if RablRails.use_custom_responder