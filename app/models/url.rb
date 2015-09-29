class Url < ActiveRecord::Base
  # generate the short url
  def generate_short
    # the short_url is equal to the id to base 36
    # even if it gets insanely large the short_url will still equal no more than six or seven letters
    self.short_url = self.id.to_s(36)
    self.save
  end
end
