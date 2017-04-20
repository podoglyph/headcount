require_relative 'enrollment'
require 'csv'
#require 'pry'

class EnrollmentRepository
  attr_reader :enrollments, :csv_data

  def initialize
    @enrollments = {}
  end

  def load_data(args)
    @csv_data = CSV.open args[:enrollment][:kindergarten], headers: true,
                              header_converters: :symbol
    enrollment_objects = extract_enrollments(csv_data)
  end

  def find_by_name(name)
    if @enrollments.keys.include? name.upcase
      @enrollments[name.upcase]
    else
      nil
    end
  end

  def extract_enrollments(csv_data)
    csv_data.each do |row|
      add_or_create_district(row)
    end
  end

  def add_or_create_district(data_row)
    if name_exists?(data_row)
      set_enrollment_data(data_row)
    else
      create_enrollment(data_row)
    end
  end

  def name_exists?(data_row)
    @enrollments.keys.include? data_row[:location].upcase
  end

  def set_enrollment_data(data_row)
    enr = find_by_name(data_row[:location])
    enr.kindergarten_participation = enr.kindergarten_participation
                                        .merge(year_data_set(data_row))
  end

  def year_data_set(data_row)
    {data_row[:timeframe].to_i => data_row[:data].to_f}
  end

  def create_enrollment(data_row)
    @enrollments[data_row[:location].upcase] =
      Enrollment.new({:name => data_row[:location].upcase,
                      :kindergarten_participation => year_data_set(data_row)})
  end
end
