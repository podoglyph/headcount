# require 'pry'
# require 'pry-state'

class District
  attr_reader :name

  def initialize(csv_row)
    @name = csv_row[:name]
  end

end
