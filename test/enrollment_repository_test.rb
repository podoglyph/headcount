require_relative 'test_helper'
require_relative '../lib/enrollment_repository.rb'

class EnrollmentRepositoryTest < Minitest::Test

  def test_it_exists
    e = EnrollmentRepository.new

    assert_equal EnrollmentRepository, e.class
  end

  def test_find_by_name
    e = EnrollmentRepository.new
    e.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
        }
      })
    enrollment = e.find_by_name("ACADEMY 20")
    assert_equal "ACADEMY 20" , enrollment.name
  end

  def test_extract_enrollments
    e = EnrollmentRepository.new
    e.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
        }
      })
    enrollment = e.find_by_name("ACADEMY 20")

  end

end
