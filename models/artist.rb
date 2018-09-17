class Artist
  attr_accessor :name
  attr_reader :albums

  def initialize(name)
    @name = name
    @albums = []
  end

  def add_album(album)
    if !check_for_repeated_albums(album.title)
      @albums << album
      puts "Added \"#{album.title}\" by #{@name}"
    else
      puts "Artist already has this album. Try a different one."
    end
  end

  def find_album(album_name)
    @albums.find do |album|
      album.title == album_name
    end
  end

  def find_and_play_album(album_name)
    album = find_album(album_name)

    if album
      album.play
    else
      puts "That album does not exist for this artist. Please select an album that exists"
    end
  end

  private

  def check_for_repeated_albums(album_name)
    found_album = find_album(album_name)

    if found_album
      return true
    end

    false
  end
end