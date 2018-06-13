class ShortenUrl
  def initialize(shortlink: '')
    @shortlink = shortlink
  end

  def shorten!
    @shortlink.update_attributes(link_hash: generate_hash_from_shortlink)
    true
  end

  private

  def generate_hash_from_shortlink
    Base32.encode(Digest::MD5.digest("#{@url}#{DateTime.now.strftime('%Q')}"))[0..4]
  end
end
