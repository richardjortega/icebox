require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))

class HumanFileSizeSupportTest < Test::Unit::TestCase

  def test_megabytes
    assert_equal 3*1024*1024, 3.MB
  end

  def test_kilobytes
    assert_equal 7*1024, 7.kilobytes
  end

end
