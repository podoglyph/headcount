require_relative 'district.rb'
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
    # get a list of all locations that we can search
  end

  def extract_locations(contents)
    #create a list we can search.
    contents = contents.map do |x|
      name = x[:location]
      x = District.new(name)
    end
  end

  def find_by_name(find_name)
    #find a specific name in the list of districts
    find_name = find_name.upcase
    @districts_list.each do |district|
      searchable_name = district.name.upcase
      if find_name == searchable_name
        return district
      end
    end
  end

  def find_all_matching(data)
    name_two = data.upcase
    matched = []
    @districts_list.each do |district|
      searchable_name = district.name.upcase
      if searchable_name.start_with?(name_two)
        matched << district
      end
    end
    matched
    #find_all_matching - returns either [] or one or more matches which contain the supplied name fragment, case insensitive
  end

end
