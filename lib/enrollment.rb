# require 'pry'
# require 'pry-state'

class Enrollment
  attr_reader :name
  attr_accessor :kindergarten_participation

  def initialize(data)
    @name = data[:name]
    @kindergarten_participation = data[:kindergarten_participation]
  end

  def kindergarten_participation_by_year
    kindergarten_participation
  end

  def kindergarten_participation_in_year(year)
    kindergarten_participation[year].round(3)
  end

end
