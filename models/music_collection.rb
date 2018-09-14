class MusicCollection
  attr_reader :artists

  def initialize(artist=nil)
    @artists = []
    if artist
      @artists << artist
    end
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist(artist_name)
    @artists.find do |artist|
      artist.name == artist_name
    end
  end

  def add_album(album_title, artist_name)
    album = Album.new(album_title)
    matched_artist = find_artist(artist_name)

    if matched_artist
      matched_artist.add_album(album)
    else
      artist = Artist.new(artist_name)
      artist.add_album(album)
      add_artist(artist)
    end
  end

  def find_album_and_play(album_name)
    @artists.each do |artist|
      artist.albums.each do |album|
        if album.name == album_name
          album.play
        else
          puts "That album does not exist. Please select an album that exists"
        end
      end
    end
  end

  def list_all_albums(by_artist=nil)
    @artists.each do |artist|
      artist.albums.each do |album|
        puts "\"#{album.title}\" by #{artist.name} (#{played?(album.played)})"
      end
    end
  end

  def show(unplayed, artist=nil)
    if unplayed

    else
      list_all_albums
    end
  end

  private

  def prevent_album_title_clashes

  end

  def played?(album_played)
    if album_played
      return "played"
    end
    return "unplayed"
  end
end