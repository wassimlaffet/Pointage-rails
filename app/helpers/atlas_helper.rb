module AtlasHelper
   
  require 'soap/wsdlDriver'
  require 'soap/header/simplehandler'
  
  NS_SHARED =  "http://advertising.microsoft.com/v2/Shared/AtlasShared";
  
  # This is a helper class that is used
  # to construct the request header.
  class RequestHeader < SOAP::Header::SimpleHandler
      def initialize (element, value)
          super(XSD::QName.new(NS_SHARED, element))
          @element = element
          @value    = value
      end
      
      def on_simple_outbound
          @value
      end
      
  end
  
  def GetPlacementsByCostPackage(username, 
                                 password, 
                                 devToken,
                                 costPackageId)
  
      wsdl  = SOAP::WSDLDriverFactory.new("https://atlasapi.atlassolutions.com/Service/CampaignManagement/v3/CampaignManagementService.svc?wsdl")
      
      # Set up the client that will communicate
      # with the web service.
      client = wsdl.create_rpc_driver
  
      # For SOAP debugging information,
      # uncomment the following statement.
      # client.wiredump_dev = STDERR
  
      # Create the request headers.
      userCredentials = 
      {
          :UserName => "#{username}",
          :Password  => "#{password}"
      }
  
      client.headerhandler << RequestHeader.new('UserCredentials', userCredentials)
      client.headerhandler << RequestHeader.new('DeveloperToken' , devToken)
  
      # Create a filter.
      filter =
      {
          :LastModifiedDateFrom => DateTime.new(2000, 1, 1),
          :LastModifiedDateTo => DateTime.now(),
          :ReportVisibility => 'ShowAll'
      }
  
      request =
      {
         :CostPackageId => costPackageId,
         :FilterCriteria => filter,
      }
  
  
      begin 
          # Perform the service operation.
          response = client.GetPlacementListByCostPackageId(request)
  
          # Get the response list.
          placementList = response.identifiers.identifier
         
          # If only one object is returned,
          # convert the result to a list.
          if ! placementList.respond_to?('each')
              placementList = [placementList]
          end
            
          # Print the list of placements.
          placementList.each do |placement|
            puts "Placement #{placement['Id']}" +
                  " - #{placement['Name']}"
          end
            
      # Capture any Microsoft Atlas Campaign
      # Management API exceptions.
      rescue SOAP::FaultError => fault
          # Get the ApiFaultDetail object.
          detail = fault.detail.apiFaultDetail
          
          # Report any operation errors.
          opErrors = detail.operationErrors
          
          # If only one operation error has occurred,
          # convert the result to a list.
          if ! opErrors.respond_to?('each')
              opErrors = [opErrors]
          end
          
          opErrors.each do |opError|
              puts "Operation error encountered."
              puts "\tError Code: #{opError.operationError.code}"
              puts "\t   Message: #{opError.operationError.message}"
          end
           
          # Report any batch errors.
          bErrors = detail.batchErrors
          
          # If only one batch error has occurred,
          # convert the result to a list.
          if ! bErrors.respond_to?('each')
              bErrors = [bErrors]
          end
  
          bErrors.each do |bError|
              puts "Batch error encountered."
              puts "\tError Index: #{bError.batchError.index}"
              puts "\t       Code: #{bError.batchError.code}"
              puts "\t    Message: #{opError.operationError.message}"
          end
  
      # Capture any exceptions on the client that are unrelated to the
      # Campaign Management API; for example, an out-of-memory
      # condition on the client.
      rescue Exception => e
          puts "Error '#{e.message} encountered."
      end
  end
end