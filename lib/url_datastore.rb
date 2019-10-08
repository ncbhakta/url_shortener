require 'singleton'

class URLDatastore
  include Singleton

  def index(url)
    @data.index(url)
  end

  def exists?(url)
    @data.include?(url)
  end

  def add(url)
  end
end
