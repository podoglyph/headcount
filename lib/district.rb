# require 'pry'
# require 'pry-state'

class District
  attr_reader :name

  def initialize(csv_data)
    @name = csv_data[:name]
  end

end
