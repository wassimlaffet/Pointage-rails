Resque.redis = 'localhost:6379'
require 'resque_scheduler'
Resque.schedule = YAML.load_file(File.join(File.dirname(__FILE__), '../resque_schedule.yml'))

#Resque.inline = Rails.env.test?