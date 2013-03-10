require 'logger'

module Icebox
  module Util
    
    def logger
      @logger ||= Logger.new(STDOUT).tap { |logger| logger.level = Logger::DEBUG }      
    end
    
    def shell_exec(command)
      logger.debug "executing #{command}"
      `#{command}`.tap do |v|
        raise "Nonzero exit value for #{command}: #{$?.inspect}: #{v}" unless $? == 0
      end
    end
    
  end
end
