require 'aws/simple_db'

module Icebox
  class ArchivedFile
    
    attr_reader :name, :md5, :archive_id
      
    def self.find_by_md5(md5)
      if item = domain.items[md5]
        from_item(item)
      end
    end
    
    def self.from_item(item)
      ArchivedFile.new(item.attributes['name'].first, item.attributes['md5'].first, item.attributes['archive_id'].first)
    end
    
    def initialize(name, md5, archive_id)
      @name = name
      @md5 = md5
      @archive_id = archive_id
    end
    
    def save!
      item = domain.items[md5]
      ['name', 'md5', 'archive_id'].each { |name| item.attributes[name].add(self.send(name.to_sym)) }
    end
    
    private
    
    def self.domain
      AWS::SimpleDB.new.domains['icebox_archived_files'] 
    end
    
  end
end
