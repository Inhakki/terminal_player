require_relative './models/interface'

def run_program
  Interface.new.start_console
end

run_program