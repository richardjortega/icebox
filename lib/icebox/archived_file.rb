require 'aws/simple_db'

module Icebox
  class ArchivedFile
    
    attr_reader :name, :md5
      
    def self.find_by_md5(md5)
      if item = domain.items[md5]
        from_item(item)
      end
    end
    
    def self.from_item(item)
      ArchivedFile.new(item.attributes['name'], item.attributes['md5'])
    end
    
    def initialize(name, md5)
      @name = name
      @md5 = md5
    end
    
    private
    
    def self.domain
      AWS::SimpleDB.new.domains['icebox_archived_files'] 
    end
    
  end
end
