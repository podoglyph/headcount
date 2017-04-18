class HeadcountAnalyst
  attr_reader :repo, :average_district_participation

  def initialize(district_repository)
    @repo = district_repository
  end

  def kindergarten_participation_rate_variation(district_name, base)
    district = @repo.find_by_name(district_name)
    acquire_single_district_stats(district)
    average_district_participation
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

  def acquire_all_districts
    repo.enrollment_repo.enrollments
  end

  def extract_aggregate_data
    aggregate_statewide_stats = []
    acquire_all_districts.each_key do |k|
      k.kindergarten_participation.each_value {|value| aggregate_statewide_stats << value }
    end
    @aggregate_statewide_stats
  end

end
