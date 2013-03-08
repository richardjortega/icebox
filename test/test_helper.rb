require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'icebox'))
require 'test/unit'
require 'tempfile'

module Icebox
  module Test
    include Icebox::Util
    
    def fill_file(name, size_in_mb=1)
      return if size_in_mb == 0
      output = `dd if=/dev/zero of=#{name} count=#{1024*size_in_mb} bs=1024`
      logger.debug("filling file #{name} with #{size_in_mb}MB: #{output}")
    end
    
    def temp_file(name="icebox_tmp_#{Time.now.to_i}", size_in_mb=0)
      new_file = Tempfile.new(name)
      fill_file(name, size_in_mb)
      new_file.path
    end
  end
end