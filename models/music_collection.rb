require 'byebug'
require_relative './album'
require_relative './artist'

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
    if validate_uniqueness_of_album(album_title)

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
  end

  def find_album_and_play(album_name)
    @artists.each do |artist|
      artist.albums.each do |album|
        if album.title == album_name
          album.play
        else
          puts "That album does not exist. Please select an album that exists"
        end
      end
    end
  end

  def list_all_albums_or_by_artist(unplayed, artist_name=nil)
    if artist_name
      artist = find_artist(artist_name)
      show_unplayed_or_played_albums(unplayed, artist)
      return
    end

    @artists.each do |artist|
      show_unplayed_or_played_albums(unplayed, artist)
    end
  end

  def show_unplayed_or_played_albums(unplayed_only, artist)
    artist.albums.each do |album|
      if unplayed_only
        unless album.played
          puts "\"#{album.title}\" by #{artist.name}"
        end
      else
        puts "\"#{album.title}\" by #{artist.name} (#{played?(album.played)})"
      end
    end
  end

  private

  def validate_uniqueness_of_album(album_title)
    name_usable = true
    @artists.each do |artist|
      artist.albums.each do |album|
        if album_title == album.title
          name_usable = false
          puts "\"#{album.title}\" already exists in collection under #{artist.name}"
        end
      end
    end

    name_usable
  end

  def played?(album_played)
    if album_played
      return "played"
    end
    return "unplayed"
  end
end