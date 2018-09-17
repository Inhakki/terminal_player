require_relative 'spec_helper'
require_relative '../models/artist'
require_relative '../models/album'


RSpec.describe 'artist' do
  describe 'Artist instantiates and adds albums.' do
    let(:artist) { Artist.new("The Police") }
    let(:album) { Album.new("Synchronicity") }

    it "should return The Police as a name" do
      expect(artist.name).to eq("The Police")
    end

    it "should be able to add an album" do
      expect(artist.albums).to be_empty
      expect(STDOUT).to receive(:puts).with('Added "Synchronicity" by The Police')
      artist.add_album(album)
      expect(artist.albums).to_not be_empty
    end

    it "should not allow albums to be added twice with the same title for the same artist" do
      expect(artist.albums).to be_empty
      expect(STDOUT).to receive(:puts).with('Added "Synchronicity" by The Police')
      artist.add_album(album)
      expect(STDOUT).to receive(:puts).with('Artist already has this album. Try a different one.')
      artist.add_album(album)
    end
  end

  describe "Other methods in artist should help traverse albums and perform other operations" do
    let(:artist) { Artist.new("The Police") }
    let(:album)  { Album.new("Synchronicity") }
    let(:album2) { Album.new("Regatta De Blanc") }
    let(:album3) { Album.new("Ghost in the Machine") }
    let(:album4) { Album.new("Outlandos d'Amour") }

    before(:each) do
      artist.add_album(album)
      artist.add_album(album2)
      artist.add_album(album3)
      artist.add_album(album4)
    end

    it "should find an album" do
      expect(artist.find_album(album4.title)).to eq(album4)
    end

    it "should find the album to play and play it" do
      expect(album4.played).to eq(false)
      expect(STDOUT).to receive(:puts).with("You're listening to \"#{album4.title}\"")
      artist.find_and_play_album(album4.title)
      expect(album4.played).to eq(true)
    end

    it "should return an error message if the album is not found" do
      expect(album3.played).to eq(false)
      expect(STDOUT).to receive(:puts).with("That album does not exist for this artist. Please select an album that exists")
      artist.find_and_play_album("Kind Of Blue")
      expect(album3.played).to eq(false)
    end

    it "should not allow same album to be added to artist" do
      expect(STDOUT).to receive(:puts).with("Artist already has this album. Try a different one.")
      artist.add_album(Album.new("Outlandos d'Amour"))
    end
  end
end
