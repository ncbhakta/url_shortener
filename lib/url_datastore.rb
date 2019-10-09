require 'singleton'

class URLDatastore
  include Singleton

  def initialize
    @data = []
  end

  def index(url)
    @data.index(url)
  end

  def exists?(url)
    @data.include?(url)
  end

  def add(url)
    @data << url unless exists?(url)
  end

  private

  def size
    @data.size
  end
end
