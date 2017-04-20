require_relative 'test_helper'
require_relative '../lib/headcount_analyst'
require_relative '../lib/district_repository'
require 'rake/testtask'

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
    assert_instance_of DistrictRepository, ha.repo
  end

  def test_average_of_district_kindergarten_participation
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
        }
      })
    ha = HeadcountAnalyst.new(dr)
    actual = ha.kindergarten_participation_rate_variation('ACADEMY 20',
                                                          :against => 'COLORADO')
    expected = 0.766

    assert_equal expected, actual
  end

  def test_kindergarten_participation_rate_variation
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
        }
      })
    ha = HeadcountAnalyst.new(dr)

    actual = ha.kindergarten_participation_rate_variation('ACADEMY 20',
                                          :against => 'YUMA SCHOOL DISTRICT 1')
    expected = 0.447

    assert_equal actual, expected
  end

  def test_kindergarten_participation_rate_variation_trend
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
        }
      })
    ha = HeadcountAnalyst.new(dr)

    actual = ha.kindergarten_participation_rate_variation_trend('ACADEMY 20',
                                          :against => 'Colorado')
    expected = {2007=>0.992, 2006=>1.05, 2005=>0.961,
                2004=>1.258, 2008=>0.718, 2009=>0.652,
                2010=>0.681, 2011=>0.728, 2012=>0.689,
                2013=>0.694, 2014=>0.661}

    assert_equal expected, actual
  end
end
