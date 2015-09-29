require 'pry'
class Url < ActiveRecord::Base
  # each of these must be present
  validates :long_url, :presence => true
  before_create :validate_original
  after_create :generate_short
  
  # if user does not have http or in future when calling http
  def validate_original
    if !long_url.match(/^http/)
      self.long_url = "http://#{long_url}"
    end
  end

  # generate the short url
  def generate_short
    binding.pry
    # the short_url is equal to the id to base 36
    # even if it gets insanely large the short_url will still equal no more than six or seven letters
    self.short_url = self.id.to_s(36)
    self.save
  end
end
