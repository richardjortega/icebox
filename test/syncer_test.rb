require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))

class SyncerTest < Test::Unit::TestCase
  include Icebox
  include Icebox::Test

  def test_uploads_all_children_and_grandchildren
    example = create_simple_folder
    syncer = Syncer.new(example[:root], mock_upload_queue)
    syncer.sync
    assert_equal example[:contents].size, mock_upload_queue.size
  end



  private

  def mock_upload_queue
    @mock_upload_queue ||= []
  end

  def create_simple_folder
    root = File.expand_path(File.join(File.dirname(__FILE__), 'data', 'simple_folder'))
    FileUtils.rm_rf(root)
    dir_a = File.join(root, 'a')
    dir_aa = File.join(root, 'a', 'aa')
    dir_b = File.join(root, 'b')
    FileUtils.mkdir_p(dir_aa)
    FileUtils.mkdir_p(dir_b)
    a1 = File.join(dir_a, 'a1')
    a2 = File.join(dir_a, 'a2')
    aa1 = File.join(dir_aa, 'aa1')
    b1 = File.join(dir_b, 'b1')
    { :root => root, :contents => [a1, a2, aa1, b1] }.tap do |info|
       info[:contents].each_with_index { |file, idx| fill_file(file, (idx+1).KB) }
    end
  end

end
