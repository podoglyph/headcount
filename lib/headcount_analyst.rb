class HeadcountAnalyst
  attr_reader :repo, :average_district_participation

  def initialize(district_repository)
    @repo = district_repository
  end

  def kindergarten_participation_rate_variation(d,options={against: "Colorado"})
    district1 = @repo.find_by_name(d)
    district2 = @repo.find_by_name(options[:against])
    stats1 = acquire_single_district_stats(district1)
    stats2 = acquire_single_district_stats(district2)
    (stats1/stats2).round(3)
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

  def kindergarten_participation_rate_variation_trend(district, options)
    d1=@repo.find_by_name(district).kindergarten_participation_by_year
    d2=@repo.find_by_name(options[:against]).kindergarten_participation_by_year
    trends = {}
    by_year_data = d1.zip(d2)
    by_year_data.map do |d1_set, d2_set|
      years_and_data = d1_set.zip(d2_set)
      years_and_data.first.uniq!
      year = years_and_data[0][0]
      data = years_and_data[1]
      average = data.inject(:+)/data.count
      trends[year] = average.round(3)
    end
    trends
  end
end
