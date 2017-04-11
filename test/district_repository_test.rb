require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/district_repository.rb'

class DistrictRepositoryTest < Minitest::Test

  def test_it_exists
    d = DistrictRepository.new

    assert_equal DistrictRepository, d.class
  end

  def test_load_districts
    d = DistrictRepository.new
    d.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
        }
      })
    district = d.find_by_name("ACADEMY 20")
    assert_equal "ACADEMY 20" , district.name
    assert_instance_of District, district
  end

end
