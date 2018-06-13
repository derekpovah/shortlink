class ShortenUrl
  def initialize(shortlink: '')
    @shortlink = shortlink
  end

  def shorten!
    @shortlink.update(link_hash: generate_hash_from_shortlink)
    true
  end

  private

  def generate_hash_from_shortlink
    Base32.encode(Digest::MD5.digest("#{@url}#{Time.now.to_f}"))[0..4]
  end
end
