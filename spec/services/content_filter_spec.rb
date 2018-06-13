require 'rails_helper'
require 'vcr_helper'

RSpec.describe ContentFilter, type: :service do

  describe '::call' do
    context 'with blocked url' do
      before(:each) do
        VCR.use_cassette(:content_filter_blocked) do
          blocked = ContentFilter.new(url: 'http://dilbert.com')
          @result = blocked.call
        end
      end

      it 'returns true' do
        expect(@result.blocked?).to be_truthy
      end

      it 'returns a reason for the block' do
        expect(@result.block_reason).to include('Custom - Block URL')
      end
    end

    context 'with unblocked url' do
      before(:each) do
        VCR.use_cassette(:content_filter_unblocked) do
          unblocked = ContentFilter.new(url: 'https://google.com')
          @result = unblocked.call
        end
      end

      it 'returns false' do
        expect(@result.blocked?).to be_falsy
      end
    end
  end
end
