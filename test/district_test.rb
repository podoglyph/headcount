require_relative 'test_helper'
require_relative '../lib/district'
require_relative '../lib/district_repository'
require_relative '../lib/enrollment_repository'
require 'rake/testtask'

class DistrictTest < Minitest::Test

  def test_it_exists
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
    district = dr.find_by_name("ACADEMY 20")

    assert_instance_of District, district
    assert_equal "ACADEMY 20", district.name
  end

  def test_district_can_find_relative_enrollment_object
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
    district = dr.find_by_name("ACADEMY 20")
    actual = district.enrollment.kindergarten_participation_in_year(2010)
    expected = 0.436

    assert_equal actual, expected
  end

end
