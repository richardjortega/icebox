require File.expand_path(File.join(File.dirname(__FILE__), 'util'))

module Icebox
  class LocalFileCollection
    include Util
    
    def <<(file)
      shell_exec tar('--append', "-f #{tar_filename}", file.path)
    end

    def size
      File.size(tar_filename)
    end

    def tar_filename
      @tar_filename ||= begin
        @tar_file = Tempfile.new(['icebox', '.tar'])
        logger.info("creating new empty tar #{File.basename(@tar_file.path)}")
        shell_exec tar('-c', "-f #{@tar_file.path}", '-T' '/dev/null')
        @tar_file.path
      end
    end

    alias :path :tar_filename

    private
    
    def tar(*args)
      (["tar"] + args).join(" ")
    end
    
  end
end
