class HeadcountAnalyst
  attr_reader :repo

  def initialize(district_repository)
    @repo = district_repository
  end

  #ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'COLORADO') # => 0.766

  # Now that the District object can access its relative enrollment stats, we can start to run some calculations.
  #
  # 1. Find average district participation across all years
  # 2. Find average for all districts in state across all years.
  # 3. Divide 1 by 2.

  def kindergarten_participation_rate_variation(district_name, base)
    acquire_district_kindergarten_stats(district_name)
  end

  def acquire_district_kindergarten_stats(district_name)
    district = repo.find_by_name(district_name)
    district_stats = district.enrollment.kindergarten_participation
    extract_kindergarten_participation_rates(district_stats)
  end

  def extract_average_participation_rates(stats)
    divisor = stats.length
    sum = stats.values.inject(0){|sum,x| sum + x }
    @average_district_participation = sum / divisor
  end

end
