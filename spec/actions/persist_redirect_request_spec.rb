require 'rails_helper'

RSpec.describe PersistRedirectRequest, type: :action do
  before(:all) do
    Request = ImmutableStruct.new(:referrer, :remote_ip, :user_agent)
  end
  
  before(:each) do
    request = Request.new(referrer: 'http://www.lvusd.org', remote_ip: '156.3.109.1', user_agent: 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.79 Safari/537.36')
    @shortlink = Shortlink.create(url: 'http://google.com', name: 'google')
    persist_redirect_request = PersistRedirectRequest.new(request: request, shortlink: @shortlink)
    @result = persist_redirect_request.process!
  end

  describe '#process!' do
    it 'returns true' do
      expect(@result.persisted?).to be_truthy
    end

    describe 'hit data' do
      before(:each) do
        @hit = Hit.first
      end

      it 'associates with shortlink' do
        expect(@hit.shortlink).to eq(@shortlink)
      end

      it 'persists a hit to the database' do
        expect(Hit.all.count).to eq(1)
      end

      it 'saves browser version' do
        expect(@hit.browser).to eq('Chrome 61')
      end

      it 'saves referrer' do
        expect(@hit.referrer).to eq('http://www.lvusd.org')
      end

      it 'saves IP' do
        expect(@hit.ip).to eq('156.3.109.1')
      end

      it 'saves geolocation' do
        expect(@hit.city).to eq('Calabasas')
        expect(@hit.state).to eq('California')
        expect(@hit.zip).to eq('91302')
        expect(@hit.country).to eq('US')
      end

      it 'saves operating system' do
        expect(@hit.operating_system).to eq('Generic Linux')
      end
    end
  end
end
