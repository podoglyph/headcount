require_relative 'test_helper'
require_relative '../lib/cleaner'
class CleanerTest < Minitest::Test

  def test_class_exists
    c = Cleaner.new

    assert_equal Cleaner, c.class
  end
  

end
