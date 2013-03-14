module Icebox
  module MockSimpleDb
    
    class Domain
      def initialize(archived_files)
        @archived_files = archived_files
      end
    
      def items
        {}.tap do |items|
          @archived_files.each do |archived_file|
            items[archived_file['md5'].first] = Item.new(archived_file)
          end
        end
      end

    end

    class Item

      attr_reader :attributes
      
      def initialize(attributes)
        @attributes = attributes
      end
      
    end

  end

end