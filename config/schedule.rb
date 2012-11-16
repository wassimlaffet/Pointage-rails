# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#

set :environment, :development
set :output, 'app/log/development.log'

every 2.minute do
  command "echo 'you can use raw cron syntax too'" , :environment => :development
  #runner "TestJob"
  #rake "pointage:perform"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
