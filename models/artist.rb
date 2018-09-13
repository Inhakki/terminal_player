class Artist
  attr_accessor :name
  attr_reader :albums

  def initialize(name)
    @name = name
    @albums = []
  end

  def add_album(album)
    @albums << album
  end
end