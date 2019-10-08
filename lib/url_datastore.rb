require 'singleton'

class URLDatastore
  include Singleton

  def index(url)
    @data.index(url)
  end

  def exists?(url)
  end

  def add(url)
  end
end
