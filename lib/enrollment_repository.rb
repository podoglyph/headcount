require_relative 'enrollment'
require 'csv'
require 'pry'

class EnrollmentRepository
  attr_reader :enrollments, :csv_data

  def initialize
    @enrollments = {}
  end

  def load_data(args)
    @csv_data = CSV.open args[:enrollment][:kindergarten], headers: true, header_converters: :symbol
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

  def add_or_create_district(data)
    if @enrollments.keys.include? data[:location]
      @enrollments[data[:location]] << [[data[:timeframe].to_i, data[:data].to_f]]
    else
      @enrollments[data[:location].upcase] = Enrollment.new(data)
      @enrollments[data[:location]] = [[data[:timeframe].to_i, data[:data].to_f]]
    end
  end

end
