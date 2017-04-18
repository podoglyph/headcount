require_relative 'test_helper'
require_relative '../lib/headcount_analyst'
require_relative '../lib/district_repository'

class HeadcountAnalystTest < Minitest::Test

  def test_it_exists
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
        }
      })
    ha = HeadcountAnalyst.new(dr)
    assert_instance_of HeadcountAnalyst, ha
  end

  def test_average_of_district_kindergarten_participation
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
        }
      })
    ha = HeadcountAnalyst.new(dr)
    actual = ha.kindergarten_participation_rate_variation("ACADEMY 20", "Colorado" )
    expected = 0.766
    assert_equal expected, actual
  end

  def test_extraction_of_statewide_data
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
        }
      })
    ha = HeadcountAnalyst.new(dr)
    expected = ha.average_statewide_aggregate_stats
    actual = 0.5303936363636365

    assert_equal actual, expected
  end

  # def test_average_of_statewide_stats
  #   dr = DistrictRepository.new
  #   dr.load_data({
  #     :enrollment => {
  #       :kindergarten => "./data/Kindergartners in full-day program.csv"
  #       }
  #     })
  #   ha = HeadcountAnalyst.new(dr)
  #
  #   actual = ha.average_statewide_aggregate_stats
  #   expected = 0.6876130637870412
  #
  #   assert_equal actual, expected
  # end



end
