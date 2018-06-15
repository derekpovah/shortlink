class PersistRedirectRequest
  attr_accessor :request, :shortlink

  Result = ImmutableStruct.new(:persisted?)

  def initialize(request: '', shortlink: '')
    @request = request
    @shortlink = shortlink
    @ip = request.remote_ip
    @browser = Browser.new(request.user_agent)
    @geolocation = Geokit::Geocoders::IpApiGeocoder.geocode(@ip)
  end

  def process!
    hit = Hit.new.tap do |h|
      h.browser = browser_name_and_version
      h.city = @geolocation.city
      h.state = @geolocation.state_name
      h.zip = @geolocation.zip
      h.country = @geolocation.country_code
      h.ip = @ip
      h.operating_system = @browser.platform.name
      h.referrer = @request.referrer
      h.shortlink = @shortlink
    end
    return Result.new(persisted: true) if hit.save
  end

  private

  def browser_name_and_version
    "#{@browser.name} #{@browser.version}"
  end
end
