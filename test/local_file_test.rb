require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))

class LocalFileTest < Test::Unit::TestCase
  include Icebox
  include Icebox::Test

  def setup
    @tmp_filename = temp_file(:name => 'ten_k', :size => 10.KB)
  end
  
  def test_name
    local_file = LocalFile.new(@tmp_filename)
    assert_equal File.basename(@tmp_filename), local_file.name
  end
  
  def test_path
    local_file = LocalFile.new(@tmp_filename)
    assert_equal @tmp_filename, local_file.path
  end
  
  def test_md5
    local_file = LocalFile.new(data_file('known_md5.txt'))
    assert_equal 'bb85bd3ec37c130961fb4efd4808954e', local_file.md5
  end
  
  def test_size
    local_file = LocalFile.new(@tmp_filename)
    assert_equal 10.KB, local_file.size
  end
  
  def test_to_s_includes_path
    assert_equal "<Icebox::LocalFile '#{@tmp_filename}'>", LocalFile.new(@tmp_filename).to_s
  end

end
