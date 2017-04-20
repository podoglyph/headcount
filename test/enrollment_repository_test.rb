require_relative 'test_helper'
require_relative '../lib/enrollment_repository'
require 'rake/testtask'

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

  def test_enrollment_object_created
    e = EnrollmentRepository.new
    e.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
        }
      })
    enrollment = e.find_by_name("ACADEMY 20")
    expected = {2007=>0.39159, 2006=>0.35364, 2005=>0.26709, 2004=>0.30201, 2008=>0.38456, 2009=>0.39, 2010=>0.43628, 2011=>0.489, 2012=>0.47883, 2013=>0.48774, 2014=>0.49022}

    actual = enrollment.kindergarten_participation
    assert_equal actual, expected
  end

  def test_extract_enrollments
    e = EnrollmentRepository.new
    e.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
        }
      })
    enrollment = e.find_by_name("ACADEMY 20")

    assert_instance_of Enrollment, enrollment
  end

  def test_add_or_create_district
    e = EnrollmentRepository.new
    e.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
        }
      })
    enrollment = e.find_by_name("ACADEMY 20")
  end

end
