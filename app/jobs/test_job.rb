module TestJob
  @queue = :job1
  def self.perform()
   
    pointages = Pointage.where(:hs.gte => Date.today)
    puts "count **** #{pointages.count}"
    pointages.each do |pointage|
      if !pointage.he.nil? && !pointage.hp.nil?
      duree = ((pointage.hp.to_time - pointage.hs.to_time) + (pointage.he.to_time - pointage.hr.to_time))
      elsif !pointage.he.nil? && pointage.hp.nil?
      duree =  (pointage.he.to_time - pointage.hr.to_time)
      elsif pointage.he.nil? && !pointage.hp.nil?
      duree =  (pointage.hp.to_time - pointage.hs.to_time)
      else
      duree = 0
      end
      puts duree
      pointage.update_attribute(:dr, duree)
      pointage.save
    end
  end
end