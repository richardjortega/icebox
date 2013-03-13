module Icebox
  class Syncer

    def initialize(folder, vault, queue = UploadQueue.new)
      @folder = folder
      @queue = queue
      @vault = vault
    end

    def sync
      Dir["#{@folder}/**/*"].reject { |f| File.directory?(f) }.sort.each do |file|
        upload LocalFile.new(file)
      end
    end

    private

    def upload(file)
      return if previously_uploaded? file
      @queue << file
    end

    def previously_uploaded?(file)
      @vault.find_by_md5(file.md5)
    end

  end
end
