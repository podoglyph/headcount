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

  def test_aggregate_of_district_kindergarten_participation
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
        }
      })
    hc = HeadcountAnalyst.new(dr)
    actual = hc.kindergarten_participation_rate_variation("ACADEMY 20", nil)
    expected = {2007=>0.39159,
                 2006=>0.35364,
                 2005=>0.26709,
                 2004=>0.30201,
                 2008=>0.38456,
                 2009=>0.39,
                 2010=>0.43628,
                 2011=>0.489,
                 2012=>0.47883,
                 2013=>0.48774,
                 2014=>0.49022}

    assert_equal actual, expected
  end

  def test_average_of_aggregate_district_data
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
        }
      })
    hc = HeadcountAnalyst.new(dr)
    hc.kindergarten_participation_rate_variation("ACADEMY 20", nil)
  end

end
