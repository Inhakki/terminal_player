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

  describe "Music collection's find functions work properly" do
    let(:artist) { Artist.new("The Eagles") }
    let(:album)  { Album.new("Greatest Hits") }
    let(:album2) { Album.new("Hotel California") }
    let(:artist2) { Artist.new("Tupac Shakur") }
    let(:album3) { Album.new("All Eyez On me") }
    let(:music_collection) { MusicCollection.new }

    before(:each) do
      artist.add_album(album)
      artist.add_album(album2)
      artist2.add_album(album3)
      music_collection.add_artist(artist)
      music_collection.add_artist(artist2)
    end

    it "should not allow adding albums of the same name in a music collection" do
      expect(STDOUT).to receive(:puts).with("\"#{album.title}\" already exists in collection under #{artist.name}")
      music_collection.add_album("Greatest Hits", "Tupac Shakur")
      expect(music_collection.find_artist("Tupac Shakur").albums.count).to eq(1)
    end

    it "should display unplayed albums only" do
      unplayed = true
      music_collection.find_artist(artist.name).albums[0].play
      expect(STDOUT).to receive(:puts).with("\"#{album2.title}\" by #{artist.name}")
      expect(STDOUT).to receive(:puts).with("\"#{album3.title}\" by #{artist2.name}")
      music_collection.list_all_albums_or_by_artist(unplayed)
    end

    it "should show unplayed albums by one artist only" do
      unplayed = true
      music_collection.find_artist(artist.name).albums[0].play
      expect(STDOUT).to receive(:puts).with("\"#{album3.title}\" by #{artist2.name}")
      music_collection.list_all_albums_or_by_artist(unplayed, artist2.name)
    end

    it "should show all albums with played/unplayed aspect at the end" do
      unplayed = false
      music_collection.find_artist(artist.name).albums[0].play
      expect(STDOUT).to receive(:puts).with("\"#{album.title}\" by #{artist.name} (played)")
      expect(STDOUT).to receive(:puts).with("\"#{album2.title}\" by #{artist.name} (unplayed)")
      expect(STDOUT).to receive(:puts).with("\"#{album3.title}\" by #{artist2.name} (unplayed)")
      music_collection.list_all_albums_or_by_artist(unplayed)
    end

    it "should show all albums with played/unplayed aspect by the eagles only" do
      unplayed = false
      music_collection.find_artist(artist.name).albums[0].play
      expect(STDOUT).to receive(:puts).with("\"#{album.title}\" by #{artist.name} (played)")
      expect(STDOUT).to receive(:puts).with("\"#{album2.title}\" by #{artist.name} (unplayed)")
      music_collection.list_all_albums_or_by_artist(unplayed, artist.name)
    end
  end
end