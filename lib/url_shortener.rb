require 'url_datastore'
require 'base_converter'

class URLShortener
  include BaseConverter

  def initialize
    @url_datastore = URLDatastore.new
  end

  def shorten(url)
    @url_datastore.add(url) unless @url_datastore.exists?(url)
    index = @url_datastore.index(url)
    "/#{base_10_to_62(index.to_s)}"
  end

  def lengthen(short_url)
  end
end
