require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))

class UploadQueueTest < Test::Unit::TestCase
  include Icebox
  include Icebox::Test

  def test_enqueuing_a_big_file_immediately_uploads_it
    file = temp_local_file :size => 25.KB
    client = mock('glacier_client')
    client.expects(:upload).with(file)
    queue = UploadQueue.new(client, 20.KB)
    queue << file
  end
  
  def test_enqueuing_a_small_file_queues_it_up
    file = temp_local_file :size => 1.KB
    queue = UploadQueue.new(nil, 20.KB)
    queue << file
    assert_equal 1, queue.size
  end

  def test_enqueue_two_small_files_uploads_a_collection_of_both
    file1 = temp_local_file :size => 500.KB
    file2 = temp_local_file :size => 525.KB
    client = mock('glacier_client')
    client.expects(:upload).with do |actual|
      assert actual.size >= (500 + 525).KB
      assert_tar_contains [file1, file2], actual.path
    end
    queue = UploadQueue.new(client, 1.MB)
    queue << file1 << file2
   end

  def test_enqueue_two_groups_of_small_files_uploads_two_collections
    file_a = temp_local_file :name => 'alpha', :size => 25.KB
    file_b = temp_local_file :name => 'beta', :size => 20.KB
    file_y = temp_local_file :name => 'yak', :size => 24.KB
    file_z = temp_local_file :name => 'zed', :size => 21.KB

    client = mock('glacier_client')
    client.expects(:upload).twice
    queue = UploadQueue.new(client, 44.KB)
    queue << file_a << file_b << file_y << file_z    
  end

end
