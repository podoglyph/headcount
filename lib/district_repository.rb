require_relative 'district'
require 'csv'
# require 'pry'
# require 'pry-state'

class DistrictRepository
  attr_reader :districts

  def initialize
    @districts = {}
  end

  def load_data(args)
    csv_data = CSV.open(args[:enrollment][:kindergarten], headers: true, header_converters: :symbol)
    district_objects = extract_locations(csv_data)
    @districts = {:enrollment => {:kindergarten => district_objects}}
  end

  def extract_locations(csv_data)
    csv_data.map do |row|
      row[:name] = row[:location]
      District.new(row)
    end
  end

  def find_by_name(find_name)
    districts[:enrollment][:kindergarten].find do |district|
      district.name.upcase == find_name.upcase
    end
  end

  def find_all_matching(find_name)
    matched = []
    districts[:enrollment][:kindergarten].find_all do |district|
      if district.name.upcase.start_with?(find_name.upcase)
        matched << district.name
      end
    end
    matched.uniq
  end

end
