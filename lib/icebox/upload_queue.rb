module Icebox
  class UploadQueue
    
    def initialize(client)
      @client = client
    end
    
    def enqueue(local_file)
      queue << local_file
      process_queue
    end

    def size
      queue.size
    end
    
    private

    def process_queue
      queue.reject! do |candidate|
        if candidate.size > 250.MB
          @client.upload(candidate.path)
          true
        else
          false
        end
      end
    end

    def queue
      @queue ||= []
    end
  end
end
