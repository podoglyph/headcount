require_relative 'test_helper'
require_relative '../lib/district.rb'

class DistrictTest < Minitest::Test

  def test_it_exists
    d = District

    assert_equal District, d.class
  end
end
