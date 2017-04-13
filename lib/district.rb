# require 'pry'
# require 'pry-state'
require_relative 'district_repository'

class District
  attr_reader :name, :repo

  def initialize(csv_data)
    @name = csv_data[:name]
    @repo = csv_data[:repo]
  end

  def enrollment
    repo.enrollment_repo.find_by_name(name)
    #district.enrollment.kindergarten_participation_in_year(2010) # => 0.436
  end

end
