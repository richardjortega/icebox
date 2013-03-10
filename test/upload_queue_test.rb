require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))

class UploadQueueTest < Test::Unit::TestCase
  include Icebox
  include Icebox::Test

  def test_enqueue_a_256_mb_file_immediately_uploads_it
    file = OpenStruct.new(:path => '/tmp/256_mb_pomeranian', :size => 256.MB)
    client = mock('glacier_client')
    client.expects(:upload).with(file.path)
    queue = UploadQueue.new(client)
    queue.enqueue(file)
  end
  
  def test_enqueue_a_128_mb_file_queues_it
    file = OpenStruct.new(:path => '/tmp/128_mb_pomeranian', :size => 128.MB)
    queue = UploadQueue.new(nil)
    queue.enqueue(file)
    assert_equal 1, queue.size
  end

end
