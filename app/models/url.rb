class Url < ActiveRecord::Base
  # each of these must be present
  validates :long_url, :presence => true
  # the long_url must be unique, don't want multiples
  validates :long_url, :uniqueness => true
  
  # addition security that it is a url
  def validate_original
    if !long_url.match(/^http/)
      self.long_url = "http://#{long_url}"
    end
  end

  # generate the short url
  def generate_short
    # the short_url is equal to the id to base 36
    # even if it gets insanely large the short_url will still equal no more than six or seven letters
    self.short_url = self.id.to_s(36)
    self.save
  end
end
