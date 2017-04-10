class DistrictRepository

  def initialize


  end




  #File.read('./data/').split("\n")

  def load_data(file)
    File.read(file).split("\n")
  end

  def find_by_name
    #find_by_name - returns either nil or an instance of District having done a case insensitive search
  end

  def find_all_matching
    #find_all_matching - returns either [] or one or more matches which contain the supplied name fragment, case insensitive
  end

end
