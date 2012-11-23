module TestJob
  @queue = :job1
  def self.perform()
   Resque.enqueue(self)
    pointage = Pointage.first
  #pointages.each do |pointage|
  # if !pointage.he.nil? && !pointage.hp.nil?
  # duree = ((pointage.hp.to_time - pointage.hs.to_time) + (pointage.he.to_time - pointage.hr.to_time))
  # elsif !pointage.he.nil? && pointage.hp.nil?
  # duree =  (pointage.he.to_time - pointage.hr.to_time)
  # elsif pointage.he.nil? && !pointage.hp.nil?
  # duree =  (pointage.hp.to_time - pointage.hs.to_time)
  # else
  # duree = 0
  # end
    pointage.update_attribute(:dr, 9999)
    pointage.save
  #end
  end
end