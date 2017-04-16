require_relative 'enrollment'
require 'csv'
require 'pry'

class EnrollmentRepository
  attr_reader :enrollments, :csv_data

  def initialize
    @enrollments = {}
  end

  def load_data(args)  #<--- Loading CSV into CSV object. Converts headers to symbols. Extract enrollment iterates over each row.
    @csv_data = CSV.open args[:enrollment][:kindergarten], headers: true, header_converters: :symbol
    enrollment_objects = extract_enrollments(csv_data)

  end

  def find_by_name(name)
      @enrollments[name.upcase]  #<--- returns enrollment object or nil if it doesn't exist
  end

  def extract_enrollments(csv_data) #<--- iterates over each row of the csv object
    csv_data.each do |row|
      add_or_create_district(row)
    end
  end

  def add_or_create_district(data_row)
    if find_by_name(data_row[:location].upcase)
      set_enrollment_data(data_row)   #<--- if you already have an enrollment with that name, it just adds more data.
    else
      create_enrollment(data_row)  #<--- creates new key with district name and value of enrollment object
    end
  end

  def set_enrollment_data(data_row)  #<--- if we've already had our first piece of kindergarten participation data added.
    enr = find_by_name(data_row[:location])   #<--- enr = enrollment object with 2 attributes you can call (name, kindergarten_participation)
    enr.kindergarten_participation = enr.kindergarten_participation.merge(year_data_set(data_row))  #<--- set kindergarten part attribute to the existing hash + the new data
  end

  def year_data_set(data_row) #<--- returns hash where year is the key and the data (float) is the value
    {data_row[:timeframe].to_i => data_row[:data].to_f}
  end

  def create_enrollment(data_row) #<--- if there's a need for a new enrollment in add/create district method, this does it!
    @enrollments[data_row[:location].upcase] =   #<--- calling location row (upcased) and setting key to district name.
      Enrollment.new({:name => data_row[:location].upcase,   #<--- setting the value of the enrollment object (name)......
                      :kindergarten_participation => year_data_set(data_row)})  #<---... and kindergarten_participation which points to hash where keys are years and values are data.
  end
end
