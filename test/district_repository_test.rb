require_relative 'test_helper'
require_relative '../lib/district_repository'
#require "pry"

class DistrictRepositoryTest < Minitest::Test

  def test_it_exists
    d = DistrictRepository.new

    assert_equal DistrictRepository, d.class
  end

  def test_find_by_name
    d = DistrictRepository.new
    d.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
    district = d.find_by_name("ACADEMY 20")
    assert_equal "ACADEMY 20" , district.name
  end

  def test_find_all_matching
    d1 = District.new({:name => "Mustache County 22"})
    d2 = District.new({:name => "Richard's Mustache Academy"})
    d3 = District.new({:name => "JOELS HASH ACADEMY"})
    distric_repo = DistrictRepository.new([d1, d2, d3])
    result = distric_repo.find_all_matching ("mustaCHe")
    assert_equal [d1, d2], result

    no_result = distric_repo.find_all_matching("Padraic")
    assert_equal [], no_result
  end

  def test_enrollment_repo_is_created_on_load
    d = DistrictRepository.new
    d.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
      })

      enrollments = d.enrollment_repo
      assert_instance_of EnrollmentRepository, enrollments
    end

  end
