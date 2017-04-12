# require 'pry'
# require 'pry-state'

class Enrollment
  attr_reader :name, :kindergarten_participation

  def initialize(enrollment_data)
    @name = enrollment_data[:name]
    @kindergarten_participation = enrollment_data[:kindergarten_participation]
  end


  def kindergarten_participation_by_year
    # enrollment.kindergarten_participation_by_year
    # { 2010 => 0.391,
    #  2011 => 0.353,
    #  2012 => 0.267,
    # }


  end

  def kindergarten_participation_in_year(year)

  end

end
