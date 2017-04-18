class HeadcountAnalyst
  attr_reader :repo, :average_district_participation

  def initialize(district_repository)
    @repo = district_repository
  end

  def kindergarten_participation_rate_variation(district_name, base = nil)
    #base set to nil for now, work in progress to pipe in the correct data/format
    district = @repo.find_by_name(district_name) # just popping over to the DR to get *this* district
    acquire_single_district_stats(district) # returns the method below
    base = average_statewide_aggregate_stats # sets base to the value of the method
    result = average_district_participation / base
    result = result.round(3)
  end

  def acquire_single_district_stats(district)
    district_stats = district.enrollment.kindergarten_participation.values #if you pop over to DR you'll see that the District.new now sends the DR onto the District object, which allows us access the DR through the District object. The DR also initializes with the ER, which is how the line above do what it does, which is District Object, ER, kindergarten_participation...
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
    acquire_all_districts.each_pair do |k, v|
      v.kindergarten_participation.each_value {|value| aggregate_statewide_stats << value }
    end
    aggregate_statewide_stats
  end

  def average_statewide_aggregate_stats
    divisor = extract_aggregate_data.length
    sum = extract_aggregate_data.inject(0){|sum,x| sum + x }
    average_statewide_participation = sum / divisor
  end

  def set_statewide_average_as_baseline

  end


end
