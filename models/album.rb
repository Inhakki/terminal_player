class Album
  attr_accessor :title
  attr_reader :played

  def initialize(title)
    @title = title
    @played = false
  end

  def play
    @played = true
    puts "You're listening to " + '"' + @title + '"'
  end

end