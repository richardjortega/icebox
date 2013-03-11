module Icebox
  class UploadQueue
    
    attr_reader :size

    def initialize(client, upload_threshold=250.MB)
      @client = client
      @upload_threshold = upload_threshold
      @size = 0
    end
    
    def <<(local_file)
      if local_file.size >= @upload_threshold
        upload local_file
      else
        enqueue local_file
      end
      self
    end

    private

    def enqueue(local_file)
      queue << local_file
      @size += 1
      if queue.size >= @upload_threshold
        upload queue
        @queue = nil
        @size = 0
      end
    end

    def upload(file)
      @client.upload file
    end

    def queue
      @queue ||= LocalFileCollection.new
    end

  end
end
