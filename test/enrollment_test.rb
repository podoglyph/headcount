require_relative 'test_helper'
require_relative '../lib/enrollment.rb'

class EnrollmentTest < Minitest::Test

  def test_it_exists
    e = Enrollment

    assert_equal Enrollment, e.class
  end
end
