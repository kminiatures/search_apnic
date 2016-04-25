require 'test_helper'

class SearchApnicFileTest < Minitest::Test
  def test_head
    SearchApnic::File.new.head
  end

  def test_read
    SearchApnic::File.new.get_path
  end
end
