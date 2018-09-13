require 'spec_helper'

RSpec.describe "Album" do
  let(:album) {Album.new("Songs from the Big Chair")}

  describe "Album should be able to be instantiated and played" do
    it "should change the state of play when played for the first time. It should remain played if played again." do
      expect(album.played).to be_falsey
      expect(STDOUT).to receive(:puts).with('You\'re listening to "Songs from the Big Chair"')
      album.play
      expect(album.played).to be_truthy
      expect(STDOUT).to receive(:puts).with('You\'re listening to "Songs from the Big Chair"')
      album.play
      expect(album.played).to be_truthy
    end
  end
end