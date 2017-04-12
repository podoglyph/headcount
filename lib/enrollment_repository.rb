require_relative 'enrollment'
require 'csv'
# require 'pry'
# require 'pry-state'

class EnrollmentRepository
  attr_reader :enrollments

  def initialize
    @enrollments = Hash.new
  end

  def load_data(args)
    @contents = CSV.open args[:enrollment][:kindergarten], headers: true, header_converters: :symbol
  end

  def find_by_name(district_name)
    Enrollment.new({:name => district_name.upcase, :kindergarten_participation => extract_enrollments(district_name)})
  end

  def extract_enrollments(district_name)
    extracted = {}
    @contents.find_all do |row|
      if row[:location] == district_name.upcase
        extracted[row[:timeframe].to_i] = row[:data].to_f
      end
    end
    extracted
  end

end
