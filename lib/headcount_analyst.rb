class HeadcountAnalyst
  attr_reader :repo, :average_district_participation

  def initialize(district_repository)
    @repo = district_repository
  end

  def kindergarten_participation_rate_variation(district_name, base = nil)
    district = @repo.find_by_name(district_name)
    acquire_single_district_stats(district)
    base = average_statewide_aggregate_stats
    result = average_district_participation / base
    result = result.round(3)
  end

  def acquire_single_district_stats(district)
    district_stats = district.enrollment.kindergarten_participation.values
    extract_average_participation_rates(district_stats)
  end

  def extract_average_participation_rates(district_stats)
    divisor = district_stats.length
    sum = district_stats.inject(0){|sum,x| sum + x }
    @average_district_participation = sum / divisor
  end

  def acquire_statewide_stats
    @repo.find_by_name("COLORADO")
  end

  def extract_statewide_aggregate_stats
    acquire_statewide_stats.enrollment.kindergarten_participation.values
  end

  def average_statewide_aggregate_stats
    divisor = extract_statewide_aggregate_stats.length
    sum = extract_statewide_aggregate_stats.inject(0){|sum,x| sum + x }
    average_statewide_participation = sum / divisor
  end

end
