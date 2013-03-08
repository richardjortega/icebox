require 'logger'

module Icebox
  module Util
    
    def logger
      @logger ||= Logger.new(STDOUT).tap { |logger| logger.level = Logger::INFO }      
    end
    
  end
end