require 'rails_helper'

RSpec.describe Shortlink, type: :model do
  describe '#url' do
    it 'should validate it has http(s)' do
      subject.url = 'google.com'
      subject.valid?
      expect(subject.errors[:url]).to include('must be a valid URL')
      
      subject.url = 'http://google.com'
      subject.valid?
      expect(subject.errors[:url]).not_to include('must be a valid URL')

      subject.url = 'https://google.com'
      subject.valid?
      expect(subject.errors[:url]).not_to include('must be a valid URL')
    end

    it 'should validate it has a known tld' do
      subject.url = 'http://google.unknowntld'
      subject.valid?
      expect(subject.errors[:url]).to include('must be a valid URL')
      subject.url = 'http://google.com'
      subject.valid?
      expect(subject.errors[:url]).not_to include('must be a valid URL') 
    end
  end
end
