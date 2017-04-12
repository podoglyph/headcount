require_relative 'district'
require 'csv'
require 'pry'
require 'pry-state'

class DistrictRepository
  attr_reader :districts

  def initialize
    @districts = Hash.new
  end

  def load_data(args)
    contents = CSV.open args[:enrollment][:kindergarten], headers: true, header_converters: :symbol

    @districts_list = extract_locations(contents)
    @districts = {:enrollment => {:kindergarten => @districts_list}}
  end

  def find_by_name(find_name)
    find_name = find_name.upcase
    @districts_list.find do |district|
      district.name == find_name
    end
  end

  def find_all_matching(find_name)
    matched = []
    @districts_list.find_all do |district|
      if district.name.upcase.start_with? find_name.upcase
        matched << district.name
      end
    end
    matched.uniq

  end

  def extract_locations(contents)
    contents = contents.map do |x|
      x[:name] = x[:location]
      District.new(x)
    end
  end
end
