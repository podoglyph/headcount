require 'pry'
require 'pry-state'

  # all tests for data cleaner should be written in the test file
  # associated with classes that actually use the module.
module DataCleaner

  def name_cleaner(name)
    name.upcase
  end

  def data_cleaner(data)
    data.to_f
    # we might need to round these floats to a certain decimal point, but
    # should do it after all data has been put together later in program
  end

  # other methods might be neccessary. if there are any occurances of bad data
  # spotted, let's note them here so we can build appropriate methods to
  # handle their interferance.

end
