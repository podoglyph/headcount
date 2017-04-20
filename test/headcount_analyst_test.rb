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
                                          :against => 'YUMA SCHOOL DISTRICT 1')
    expected = {2007=>0.696, 2006=>0.677, 2005=>0.634,
                2004=>0.151, 2008=>0.692, 2009=>0.695,
                2010=>0.718, 2011=>0.744, 2012=>0.739,
                2013=>0.744, 2014=>0.745}

    assert_equal expected, actual
  end
end
