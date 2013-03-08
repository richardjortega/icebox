require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))


class LocalFileTest < Test::Unit::TestCase
  include Icebox
  include Icebox::Test

  def setup
    @tmp_filename = temp_file('ten_megs', 10)
  end


  def test_name
    local_file = LocalFile.new(@tmp_filename)
    assert_equal File.basename(@tmp_filename), local_file.name
  end
  
  def test_path
    local_file = LocalFile.new(@tmp_filename)
    assert_equal @tmp_filename, local_file.path
  end

end
