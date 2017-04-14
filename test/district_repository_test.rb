require_relative 'test_helper'
require_relative '../lib/district_repository'

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
    d = DistrictRepository.new
    d.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
        }
      })
    searched_for = d.find_all_matching("WIL")

    assert_equal 24, searched_for.length

    not_matched = d.find_all_matching("ASDF")
    assert_equal [], not_matched
  end

end
