require_relative "../models/music_collection"

RSpec.describe "Music Collection" do

  describe "Music collection can add artists and albums" do
    let(:artist) { Artist.new("Talking Heads") }
    let(:music_collection) { MusicCollection.new }

    it "should create a music collection with artists addable" do
      expect(music_collection.artists).to be_empty
      music_collection.add_artist(artist)
      expect(music_collection.artists).to_not be_empty
    end

    it "should add albums as well as artists, return appropriate message" do

    end
  end

  describe ""
end