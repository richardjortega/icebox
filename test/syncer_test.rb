require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))

class SyncerTest < Test::Unit::TestCase
  include Icebox
  include Icebox::Test

  def setup
    @example = create_simple_folder
  end

  def test_uploads_all_children_and_grandchildren
    empty_vault = Object.new
    def empty_vault.find_by_md5(md5)
      nil
    end
    syncer = Syncer.new(@example[:root], empty_vault, mock_upload_queue)
    syncer.sync
    assert_equal 4, mock_upload_queue.size
  end

  def test_does_not_upload_previously_uploaded_files
    mock_vault = mock('vault')
    mock_vault.expects(:find_by_md5).at_least_once.returns(true)
    mock_vault.expects(:find_by_md5).with(@example[:md5s][:a2]).returns(nil)
    syncer = Syncer.new(@example[:root], mock_vault, mock_upload_queue)
    syncer.sync
    assert_equal [@example[:contents][1]], mock_upload_queue.collect(&:path)
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
       File.open('a2', 'w') { |f| f.write("Deterministic md5") }
       info[:md5s] = { :a2 => LocalFile.new(a2).md5 }
    end
  end

end
