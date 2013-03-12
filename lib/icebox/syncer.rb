module Icebox
  class Syncer

    def initialize(folder, queue = UploadQueue.new)
      @folder = folder
      @queue = queue
    end

    def sync
      Dir["#{@folder}/**/*"].reject { |f| File.directory?(f) }.each do |file|
        @queue << file
      end
    end

  end
end
