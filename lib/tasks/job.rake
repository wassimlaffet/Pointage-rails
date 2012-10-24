namespace :pointage do
  task :perform do
    TestJob.perform 0
  end
end