require_relative 'district'
require 'csv'

class DistrictRepository
  attr_reader :districts

  def initialize
    @districts = []
  end

  def load_data(args)
    csv_data = CSV.open(args[:enrollment][:kindergarten], headers: true, header_converters: :symbol)
    extract_locations(csv_data)
  end

  def extract_locations(csv_data)
    csv_data.map do |row|
      row[:name] = row[:location]
      if @districts.empty? || find_by_name(row[:name]).nil?
        @districts << District.new(row) 
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
