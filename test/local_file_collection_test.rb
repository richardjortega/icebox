require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))

class LocalFileCollectionTest < Test::Unit::TestCase
  include Icebox
  include Icebox::Test
  include Icebox::Util

  def test_knows_size
    file1 = temp_local_file :size => 1.KB
    file2 = temp_local_file :size => 2.KB
    collection = LocalFileCollection.new
    collection << file1
    collection << file2
    assert collection.size >= 3.KB #mac and linux give different minimum sizes :(
  end
  
  def test_added_files_exist_inside_tar
    file1 = temp_local_file :size => 16.KB
    file2 = temp_local_file :size => 10.KB
    collection = LocalFileCollection.new
    collection << file1
    collection << file2
    local_tar_file = collection.path
    assert_tar_contains [file1, file2], local_tar_file
  end

end
