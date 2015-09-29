require 'spec_helper'

describe 'Urls' do

  context 'submitting a valid non-https url' do
    before :each do 
      @long_url = 'test.com'
      @url = Url.new
      @url.long_url = @long_url
      binding.pry
      @url.setup_short_url(@url)
    end

    it 'creates a new site entry' do 
      expect(Url.last.long_url.include?(@long_url)).to eq(true)
    end

    it 'properly sanitizes the original url' do 
      expect(Url.last.long_url).to eq("http://#{@long_url}")
    end
  end

  context 'submitting a url that has already been submitted' do 
    before :each do 
      @long_url = 'http://test.com'
      @url_first = Url.new
      @url_first.long_url = @long_url
      @url_first.setup_short_url(@url_first)

      @url_2 = 'www.test.com'
      @url_second = Url.new
      @url_second.long_url = @url_2
      @url_second.setup_short_url(@url_second)
    end

    it 'retrieves the existing site entry' do
      expect(Url.find_by(long_url: @long_url))
      
      urls = []
      Url.all.each do |site|
        urls << site if Url.long_url.include?('test.com')
      end

      expect(urls[0].long_url).to eq('http://test.com')
    end

    it 'does not create a new site entry' do 
      expect(Url.all.length).to eq(1)
      expect(@url_second.id).to eq(nil)
    end
  end

  context 'submitting a valid https url' do
    before :each do 
      @http_url = 'http://test2.com'
      @http_site = Url.new
      @http_url.long_url = @http_url
      @http_url.setup_short_url(@http_site)
      
      @https_url = 'https://test2.com'
      @https_site = Url.new
      @https_url.long_url = @https_url
      @https_url.setup_short_url(@https_site)
    end

    it 'creates a new separate site entry' do
      second_to_last = (Url.find_by(id: Url.last.id-1))

      expect(Url.last.long_url.include?('https://')).to eq(true)
      expect(second_to_last.long_url.include?('https://')).to eq(false)
    end
  end

  context 'submitting an invalid url' do
    before :each do 
      @long_url = 'gibberish'
      @url = Url.new
      @url.long_url = @long_url
      @url.setup_short_url(@url)
    end

    it 'does not create a new site entry' do 
      expect(Url.find_by(long_url: @long_url)).to eq(nil)
    end
  end

end

