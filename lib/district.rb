require_relative 'district_repository'
require_relative 'enrollment_repository'

class District
  attr_reader :name, :repo, :this_district

  def initialize(csv_data)
    @name = csv_data[:name]
    @repo = csv_data[:repo]
  end

  def enrollment
    find_relative_district_in_repo
    @enrollment
  end

  def find_relative_district_in_repo
    @this_district = repo.find_by_name(name)
    find_relative_enrollment_object(this_district.name)
  end

  def find_relative_enrollment_object(district_name)
    @enrollment = repo.enrollment_repo.find_by_name(district_name)
  end

end
