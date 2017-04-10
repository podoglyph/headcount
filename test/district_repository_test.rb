require 'minitest/autorun'
require 'minitest/pride'
require './lib/district_repository.rb'

class DistrictRepositoryTest < Minitest::Test

  def test_it_exists
    d = DistrictRepository.new
    
    assert_equal DistrictRepository, d.class
  end

  def test_load_data
    d = DistrictRepository.new
    file = d.load_data('hello.txt')

    assert_equal ["hello"], file
  end


end
