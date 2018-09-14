require_relative "../models/music_collection"

RSpec.describe "Music Collection" do

  describe "Music collection can add artists and albums" do
    let(:artist) { Artist.new("Talking Heads") }
    let(:artist2) { Artist.new("Madonna") }
    let(:music_collection) { MusicCollection.new }

    it "should create a music collection with artists addable" do
      expect(music_collection.artists).to be_empty
      music_collection.add_artist(artist)
      expect(music_collection.artists).to_not be_empty
    end

    it "should find artists easily with the find method" do
      music_collection.add_artist(artist)
      music_collection.add_artist(artist2)

      expect(music_collection.find_artist(artist2.name)).to eq(artist2)
    end

    context "For each added artist to music collection" do
      before(:each) do
        music_collection.add_artist(artist)
      end

      it "should add albums by existing artists" do
        expect(music_collection.artists.count).to eq(1)
        expect(music_collection.artists.first.albums.count).to eq(0)
        expect(STDOUT).to receive(:puts).with('Added "Remain In Light" by Talking Heads')
        music_collection.add_album("Remain In Light", "Talking Heads")
        expect(music_collection.artists.count).to eq(1)
        expect(music_collection.artists.count).to eq(1)
      end

      it "should add albums by artists that aren't already in side the collection" do
        expect(music_collection.artists.count).to eq(1)
        expect(STDOUT).to receive(:puts).with('Added "Brothers In Arms" by Dire Straits')
        music_collection.add_album("Brothers In Arms", "Dire Straits")
        expect(music_collection.artists.count).to eq(2)
      end
    end
  end

  describe "Music collection can probably find an album" do
    it "should return album title and artist when adding album" do

    end

  end
end