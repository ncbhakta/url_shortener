require_relative './url_datastore'
require_relative './base_converter'

class URLShortener
  include BaseConverter

  def initialize
    @url_datastore = URLDatastore.instance
  end

  def shorten(url)
    @url_datastore.add(url) unless @url_datastore.exists?(url)
    index = @url_datastore.index(url)
    "/#{base_10_to_62(index.to_s)}"
  end

  def lengthen(short_url)
    base62 = short_url.tr('/', '')
    index = base_62_to_10(base62).to_i
    @url_datastore.url(index)
  end
end
