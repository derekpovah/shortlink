class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || 'must be a valid URL') unless url_valid?(value)
  end

  def url_valid?(url) 
    uri = URI.parse(url) rescue false
    return false unless uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS) 
    PublicSuffix.valid?(url.split('/').last, default_rule: nil)
  end
end
