require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'icebox'))
require 'bundler'
Bundler.setup
require 'test/unit'
require 'tempfile'
require 'mocha/setup'
require 'ostruct'

module Icebox
  module Test
    include Icebox::Util
    
    def fill_file(name, size)
      return if size == 0
      output = `dd if=/dev/zero of=#{name} count=#{size/1024} bs=1024`
      logger.debug("filling file #{name} with #{size} bytes: #{output}")
      actual_size = File.size(name)
      raise "file was #{actual_size} bytes, expected #{size} bytes" unless actual_size == size
    end
    
    def temp_file(options={})
      options = {:name => "icebox_tmp_#{Time.now.to_i}", :size => 0}.merge(options)
      new_file = Tempfile.new(options[:name])
      fill_file(new_file.path, options[:size])
      new_file.path
    end
    
    def data_file(name)
      File.expand_path(File.join(File.dirname(__FILE__), 'data', name)).tap do |filename|
        raise unless File.exists?(filename)
      end
    end
  end
end
