
class Url < ActiveRecord::Base
  BASE_URL = "short-and-sweet.herokuapp.com"
  # each of these must be present
  validates :long_url, :presence => true
  before_create :validate_long
  after_create :generate_short

  validates :long_url, format: {
    with: /\S{2}\.\S{1}/,
    message: "Not a valid URL"
  }
  # if user does not have http or in future when calling http
  def validate_long
    # test to sanitize to remove slash at the end
    includes_https = false
    # Remove dangling '/'
    self.long_url = self.long_url[0..-2] if self.long_url.last == '/' 
    # Remove 'http://'
    self.long_url = self.long_url[7..-1] if self.long_url[0..6] == 'http://'
    # Remove 'https://'
    if self.long_url[0..7] == 'https://'
      self.long_url = self.long_url[8..-1]
      includes_https = true
    end
    # Remove 'www'
    self.long_url = self.long_url[4..-1] if self.long_url[0..2] == 'www'
    # Ensure the original url has 'http' or 'https' at the start
    includes_https == true ? 
      self.long_url = "https://#{self.long_url}" :
      self.long_url = "http://#{self.long_url}"
    self.long_url
  end

  # generate the short url
  def generate_short
    # the short_url is equal to the id to base 36
    # even if it gets insanely large the short_url will still 
    # equal no more than six or seven letters
    self.short_url = self.id.to_s(36)
    self.save
  end
end
