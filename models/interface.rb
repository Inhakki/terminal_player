require_relative "./music_collection"
require 'byebug'

class Interface

  def initialize
    @main_collection = MusicCollection.new
  end

  def start_console
    puts "Welcome to your music collection!"
    command = ''

    while(command != 'quit')
      input = gets.chomp()
      command_array = input.split

      case command_array[0]
        when 'add'
          # specific splits for quotes
          add_array = input.split(/\ "/).map { |item| item.gsub(/\"/, '') }
          add_album_from_commands(add_array)
        when 'play'
          play_array = input.split(/\ "/).map { |item| item.gsub(/\"/, '') }
          play_album_from_commands(play_array)
        when 'show'
          show_collection_from_commands(command_array)
        when 'quit'
          command = 'quit'
          puts 'Bye!'
        else
          default_error
      end

    end
  end

  def default_error
    puts "Unknown keyword. Use one of the following commands:"
    puts "add \"{title}\" \"{artist}\""
    puts "play \"{title}\""
    puts "show {all/unplayed}"
    puts "show {all/unplayed} by \"{artist}\""
    puts "quit"
  end

  private

  def add_album_from_commands(command_array)
    if command_array.length >= 3
      @main_collection.add_album(command_array[1], command_array[2])
    else
      default_error
    end
  end

  def play_album_from_commands(command_array)
    if command_array.length >= 2
      @main_collection.find_album_and_play(command_array[1])
    else
      default_error
    end
  end

  def show_collection_from_commands(command_array)
    if command_array.length == 2
      validated_command = check_syntax_of_played(command_array[1])
      if validated_command[:valid]
        @main_collection.list_all_albums_or_by_artist(validated_command[:unplayed])
      end
    elsif command_array.length >= 3
      validated_command = check_syntax_of_played(command_array[1])
      if (command_array[2] == 'by')
        artist_name = command_array.drop(3).join.gsub(/\"/, '')
        @main_collection.list_all_albums_or_by_artist(validated_command[:unplayed], artist_name)
      else
        default_error
      end
    else
      default_error
    end
  end

  def check_syntax_of_played(command)
    if command == 'all'
      { unplayed: false, valid: true}
    elsif command == 'unplayed'
      { unplayed: true, valid: true}
    else
      puts "Enter valid parameter, unplayed or all only"
      { unplayed: false, valid: false }
    end
  end

end