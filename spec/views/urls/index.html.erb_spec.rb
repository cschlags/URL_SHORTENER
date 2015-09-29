require 'rails_helper'

RSpec.describe "urls/index", :type => :view do
  before(:each) do
    assign(:urls, [
      Url.create!(
        :long_url => "Long Url",
        :short_url => "Short Url"
      ),
      Url.create!(
        :long_url => "Long Url",
        :short_url => "Short Url"
      )
    ])
  end

  it "renders a list of urls" do
    render
    assert_select "tr>td", :text => "Long Url".to_s, :count => 2
    assert_select "tr>td", :text => "Short Url".to_s, :count => 2
  end
end