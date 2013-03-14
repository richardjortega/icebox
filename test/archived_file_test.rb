require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))

class ArchivedFileTest < Test::Unit::TestCase
  include Icebox
  include Icebox::Test
  
  def test_find_by_md5_returns_nil_if_not_found
    with_mock_simple_db
    assert_nil ArchivedFile.find_by_md5('1fdd820a2da31e2f551b12774074ba08')
  end
  
  def test_find_by_md5_returns_archived_file_when_found
    with_mock_simple_db([{'md5' => ['1fdd820a2da31e2f551b12774074ba08'], 'name' => ['whatever'], 'archive_id' => []}])
    archived_file = ArchivedFile.find_by_md5('1fdd820a2da31e2f551b12774074ba08')
    assert_equal '1fdd820a2da31e2f551b12774074ba08', archived_file.md5
    assert_equal 'whatever', archived_file.name
  end
  
  # def test_save_saves_all_attributes
  #   with_mock_simple_db
  #   archived_file = ArchiveFile.new('nombre', 'xyz123', 'xyz789')
  #   archived_file.save!
  #   
  # end

  private
  
  def with_mock_simple_db(existing_files=[])
    AWS::SimpleDB.any_instance.stubs(:domains).returns('icebox_archived_files' => MockSimpleDb::Domain.new(existing_files))
  end
  
end
