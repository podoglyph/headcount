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
    hc = HeadcountAnalyst.new(dr)
    assert_instance_of HeadcountAnalyst, hc
  end

  def test_average_of_district_kindergarten_participation
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
        }
      })
    hc = HeadcountAnalyst.new(dr)
    actual = hc.kindergarten_participation_rate_variation("ACADEMY 20", nil)
    expected = 0.4064509090909091

    assert_equal actual, expected
  end

  def test_extraction_of_statewide_data
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
        }
      })
    hc = HeadcountAnalyst.new(dr)

    
  end
end
