class Interface

  def start_console
    puts "Welcome to your music collection!"
    main_collection = MusicCollection.new
    command = ''

    while(command != 'quit')
      input = gets.chomp()
      command_array = input.split

      debugger
      case command_array[0]
        when 'add'

        when 'play'
        when 'show'

        else
          default_error
      end

    end
  end

  def default_error
    puts "Unknown keyword. Use one of the following commands:"
    puts "add {title} {artist}"
    puts "play {title}"
    puts "show {all/unplayed}"
    puts "show {all/unplayed} by {artist}"
    puts "quit"
  end
end