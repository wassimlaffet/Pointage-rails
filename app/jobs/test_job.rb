module TestJob
  @queue = :job1
  def self.perform(i)
    puts "Test #{i}"
    #Resque.enqueue(self, i + 1)
  end
  
end