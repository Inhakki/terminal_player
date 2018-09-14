class MusicCollection

  attr_reader :artists

  def initialize(artist=nil)
    @artists = []
    if artist
      @artists << artist
    end
  end

  def list_all_albums
    @artists.each do |artist|
      artist.albums.each do |album|
        puts "\"#{album.title}\" by #{artist.name} (#{played?(album.played)})"
      end
    end
  end

  def add_artist(artist)
    @artists << artist
  end

  def add_album(album_title, artist_name)
    album = Album.new(album_title)

    matched_artist = @artists.find do |artist|
      artist.name == artist_name
    end

    if matched_artist
      matched_artist.add_album(album)
    else
      artist = Artist.new(artist_name)
      artist.add_album(album)
      add_artist(artist)
    end


  end

  def show(unplayed, artist=nil)

  end

  private

  def played?(album_played)
    if album_played
      return "played"
    end
    return "unplayed"
  end

end