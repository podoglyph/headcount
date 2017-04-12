require 'pry'
require 'pry-state'

  #all tests for data cleaner should be written in the test file associated with classes that actually use the module.


module DataCleaner

  def name_cleaner
    #should take all data being passed through and convert it to uppercase before passing out
  end

  def integer_data_cleaner
    #should take all data being passed through and make sure it's a float of spec designated length
    #if not a float (bad data which is anything that's NOT a float) it should be disregarded or "skipped over"
  end

  #other methods might be neccessary. if there are any occurances of bad data spotted, let's note them here
  #so we can build appropriate methods to handle their interferance.

end
