require 'minitest/autorun'
require 'minitest/pride'
require './lib/district_repository.rb'

class DistrictRepositoryTest < Minitest::Test

  def test_it_exists
    d = DistrictRepository.new
    assert_equal DistrictRepository, d.class
  end

  def test_it_can_load_file
    d = DistrictRepository.new
    # File.read('./data/').split("\n")
    
  end


end
