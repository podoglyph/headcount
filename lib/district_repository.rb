require_relative 'district'
require_relative 'enrollment_repository'
require 'csv'

class DistrictRepository
  attr_reader :districts, :enrollment_repo

  def initialize
    @districts = []
    @enrollment_repo = EnrollmentRepository.new
  end

  def load_data(args)
    csv_data = CSV.open(args[:enrollment][:kindergarten], headers: true, header_converters: :symbol)
    load_data_into_enrollment_repo
    extract_locations(csv_data)
  end

  def load_data_into_enrollment_repo
    enrollment_repo.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
        }
      })
  end

  def extract_locations(csv_data)
    csv_data.map do |row|
      row[:name] = row[:location]
      if @districts.empty? || find_by_name(row[:name]).nil?
        @districts << District.new({:name => row[:name].upcase, :repo => self})
      end
    end
  end

  def find_by_name(find_name)
    districts.find do |district|
      district.name.upcase == find_name.upcase
    end
  end

  def find_all_matching(find_name)
    districts.select do |district|
      district.name.upcase.start_with?(find_name.upcase)
    end
  end



end
