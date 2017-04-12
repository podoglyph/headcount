<<<<<<< HEAD
class TestHarness < Minitest::Test
  def self.data_dir
    File.expand_path '../data', __dir__
  end

  def self.repo
    @repo ||= DistrictRepository.from_csv(data_dir)
  end

  def repo
    TestHarness.repo
  end

  def a20
    repo.find_by_name('ACADEMY 20')
  end
end
=======
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'pry-state'
>>>>>>> 671289ec79f9798d43a1f7fcf61e6cea5b489471
