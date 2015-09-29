require 'spec_helper'

describe 'Urls' do

  context 'submitting a valid non-https url' do
    before :each do 
      @long_url = 'test.com'
      @url = Url.create(long_url: @long_url)
    end

    it 'creates a new site entry' do
      expect(Url.last.long_url.include?(@long_url)).to eq(true)
    end

    it 'properly sanitizes the original url' do 
      expect(Url.last.long_url).to eq("http://#{@long_url}")
    end
  end

  context 'submitting a valid https url' do
    before :each do 
      @long_url = 'http://test2.com'
      @http_site = Url.create(long_url: @long_url)
      
      @long_url = 'https://test2.com'
      @https_site = Url.create(long_url: @long_url)
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
      @url = Url.create(long_url: @long_url)
    end

    it 'does not create a new site entry' do 
      expect(Url.find_by(long_url: @long_url)).to eq(nil)
    end
  end

end

