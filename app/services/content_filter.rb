class ContentFilter
  attr_accessor :url

  Result = ImmutableStruct.new(:blocked?, :block_reason)

  def initialize(url: '')
    @url = url
    @response = make_request
    @body = Nokogiri::HTML(@response.response_body)
  end

  def call
    Result.new(blocked: blocked?, block_reason: block_reason)
  end

  private

  def blocked?
    return true if @response.response_code == 503 && page_title == 'LVUSD Bypass'
    false
  end

  def block_reason
    return unless blocked?
    @body.xpath('//p').last.text.split('Category:').last.strip
  end

  def page_title
    @body.xpath('//title').first.text
  end

  def make_request
    Typhoeus.get(@url)
  end
end
