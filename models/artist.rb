class Artist
  attr_accessor :name
  attr_reader :albums

  def initialize(name)
    @name = name
    @albums = []
  end

  def add_album(album)
    @albums << album
    puts "Added \"#{album.title}\" by #{@name}"
  end

  def find_album(album_name)
    @albums.find do |album|
      album.title == album_name
    end
  end
end