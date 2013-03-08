module Icebox
  class LocalFile
    
    attr_reader :path
    
    def initialize(path)
      raise "#{path} not found" unless File.exists?(path)
      @path = path
    end
    
    def name
      File.basename(@path)
    end
    
  end
end