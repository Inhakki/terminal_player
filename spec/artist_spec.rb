require_relative 'spec_helper'
require_relative '../models/artist'
require_relative '../models/album'


RSpec.describe 'artist' do
  describe 'Artist instantiates and adds tracks.' do
    let(:artist) { Artist.new("The Police") }
    let(:album) { Album.new("Synchronicity") }

    it "should return The Police as a name" do
      expect(artist.name).to eq("The Police")
    end

    it "should be able to add an album" do
      expect(artist.albums).to be_empty

      artist.add_album(album)
      expect(artist.albums).to_not be_empty
    end
  end
end