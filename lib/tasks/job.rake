namespace :pointage do
  task :perform do
    TestJob.perform
  end
end