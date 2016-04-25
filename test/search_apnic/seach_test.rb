require 'test_helper'
class SearchApnic::FileTest < Minitest::Test
  def test_by_country
    SearchApnic::Search.new.by_country('JP').include? '223.165,20.2'
    SearchApnic::Search.new.by_country('JP').print
  end
end
