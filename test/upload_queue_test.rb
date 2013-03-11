require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))

class UploadQueueTest < Test::Unit::TestCase
  include Icebox
  include Icebox::Test

  def test_enqueuing_a_big_file_immediately_uploads_it
    file = LocalFile.new(temp_file(:size => 25.KB))
    client = mock('glacier_client')
    client.expects(:upload).with(file.path)
    queue = UploadQueue.new(client, 20.KB)
    queue << file
  end
  
  def test_enqueuing_a_small_file_queues_it_up
    file = LocalFile.new(temp_file(:size => 1.KB))
    queue = UploadQueue.new(nil, 20.KB)
    queue << file
    assert_equal 1, queue.size
  end

  def test_enqueue_two_small_files_uploads_a_collection_of_both
    file1 = LocalFile.new(temp_file(:size => 500.KB))
    file2 = LocalFile.new(temp_file(:size => 525.KB))
    client = mock('glacier_client')
    client.expects(:upload).with do |actual|
      assert File.size(actual) >= (500 + 525).KB
      assert_tar_contains [file1, file2], actual
    end
    queue = UploadQueue.new(client, 1.MB)
    queue << file1 << file2
   end

end
