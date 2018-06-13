require 'rails_helper'

RSpec.describe ShortenUrl, type: 'action' do
  before(:each) do
    @shortlink = Shortlink.create(url: 'http://google.com')
    @shorten_url = ShortenUrl.new(shortlink: @shortlink)
  end

  it 'updates the short_link with a unique hash' do
    @shorten_url.shorten!
    expect(@shortlink.link_hash.present?).to be_truthy
  end
end
