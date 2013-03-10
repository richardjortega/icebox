module Icebox
  class UploadQueue
    
    def initialize(client)
      @client = client
    end
    
    def enqueue(local_file)
      
      @client.upload(local_file.name)
    end
    
  end
end