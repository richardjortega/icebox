module Icebox
  
  Dir[File.expand_path(File.join(File.dirname(__FILE__), 'icebox', "**", "*"))].each do |file|
    require file
  end
  
  def sync(folder)
    
  end
  
  module_function :sync
  
end