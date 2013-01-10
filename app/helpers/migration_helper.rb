module MigrationHelper
  def self.migrate
    client = TinyTds::Client.new(
                            :database => 'cdconfigpreprod', 
                            :username => 'captaindash@txuodiutvu', 
                            :password => '{CDTUNIS2012}', 
                            :host => 'txuodiutvu.database.windows.net',
                            :azure => true)

    result = client.execute("SELECT * FROM [Clients]")
    
    result.each do |row|
      puts "******************** row: #{row['Id']}"
    end
    
    return result.count
  end
end