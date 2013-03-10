module Icebox
  class LocalFile
    require 'digest/md5'
    
    attr_reader :path
    
    def initialize(path)
      raise "#{path} not found" unless File.exists?(path)
      @path = path
    end
    
    def name
      File.basename(@path)
    end
    
    def md5
      Digest::MD5.hexdigest(File.read(path))
    end
    
    def size
      File.size(path)
    end
    
    def to_s
      "<#{self.class} '#{path}'>"
    end
    
  end
end