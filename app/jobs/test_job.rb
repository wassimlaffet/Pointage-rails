module TestJob
  @queue = :job1
  def self.perform()

 expose(:pointages){ Pointage.where(:hs.gte => Date.today)}

    def call
      interval = 24 * 60 * 60
      pointages.each do |pointage|
        if !pointage.he.nil? && !pointage.hp.nil?
        duree = ((pointage.hp - pointage.hs) + (pointage.he - pointage.hr)) * interval
        elsif !pointage.he.nil? && pointage.hp.nil?
        duree =  (pointage.he - pointage.hr) * interval
        elsif pointage.he.nil? && !pointage.hp.nil?
        duree =  (pointage.hp - pointage.hs) * interval
        else
        duree = 0
        end
        puts duree
         pointage.update_attribute(:dr, duree)
        pointage.save
      end
      puts pointages.all.to_a
    end

    #Resque.enqueue_in(24.hours, self.calcul_Duree)

  end

end