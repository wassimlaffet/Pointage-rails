namespace :pointage do
  task :perform do
    TestJob.perform    
    Resque.enqueue(TestJob)
  end
  
end