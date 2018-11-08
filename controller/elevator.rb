require_relative '../model/request_queue.rb'
require_relative '../model/cab.rb'
require_relative '../model/button.rb'
require_relative '../lib/user_input.rb'
require_relative '../lib/display.rb'
require_relative '../lib/error_messages.rb'

class ElevatorController
  include UserInput
  attr_accessor :cab, :buttons, :quit, :floor
  attr_reader :display, :top_floor, :bottom_floor, :error
  # attr_accessor :cab, :buttons, :quit
  # NOTES you can have lots of elevators so when initilize this will take a arg
  # of how many cars (cabs) GOD

  # Elevator endpoint contract { :floors, :cabs, :type}
  def initialize(*args)
    # @number_of_floors = args[0][:floors]
    @top_floor = args[0][:floors]
    @bottom_floor = 1
    # need a q
    # @cab = Cab.new(current_floor: (1..@top_floor).sample) # can iterate here and create lots of cabs
    @cab = Cab.new # can iterate here and create lots of cabs
    @buttons = Button.new(number_of_floors: @top_floor)
    # I think I can remove this from here the display
    @display = Display.new({ floors: top_floor, current_floor: @cab.current_floor })
    @quit = false
    #dont this is needed
    # @floor = Struct.new(:request_floor, :destination_floor, :direction)
    @floor = nil
    @error = ErrorMessage.new
  end

# order of operation is this:
 # if cab is idle what ever button is pushed first is the direction it will go
 # until q is empty then it will drop off at the other floors
  # def format_request(user_input)
  #   # maybe in a class? or a module RequestHelpers
  #   # request = Struct.new(:floor, :direction)
  #   # I hate this here
  #   # I think I calc the direction here and did not know it. look into this
  #   # instead of 1,up - just 1, then I can see what the current floor is and I
  #   # determin if I need to go up or down

  #   # data = user_input.split(',')
  #   # cab.destination = data[0].to_i
  #   # if data[1].nil?
  #   #   user_input.to_i < cab.current_floor ? result = UserRequest.new(user_input.to_i, 'down') : result = UserRequest.new(user_input.to_i, 'up')
  #   # else
  #   #   result = UserRequest.new(data[0].to_i, data[1])
  #   # end

  #   cab.destination = user_input.to_i
  #   user_input.to_i < cab.current_floor ? result = UserRequest.new(user_input.to_i, 'down') : result = UserRequest.new(user_input.to_i, 'up')
  #   result
  # end

  def run
    display.start_elevator
    #move below
    # puts "what floor are you starting on? This building has #{top_floor} floors"
    # puts 'Just enter a number'
    # puts "Current location of Elevator #{cab.current_floor}"
    # puts buttons.floor_call_buttons(1) they can enter what ever they want
    until quit
      input = format_request(gets.chomp)
      if input == 'error'
        puts error.error_message
        input = format_request(gets.chomp)
      end

      cab.operate_cap(input)
      # If not 1 or 10
        # it is U || D
      if input.floor != bottom_floor && input.floor != top_floor
        puts buttons.floor_call_buttons(floor)
        print display.command

        cab.direction = format_request(gets.chomp)

        # puts " in elevator cab.direction #{cab.direction}"
        # cab.cab_request_q << Request.new(input.floor, input.direction)
        # if input.floor == cab.current_floor
        # end
      end
      # I pass the prority direction here in the input
      # it is 1 || 10

      # if input.floor == bottom_floor
      #   cab.direction = 'up'
      # end
      cab.direction = 'up' if input.floor == bottom_floor
      cab.direction = 'down' if input.floor == top_floor

      # if input.floor == top_floor
      #   cab.direction = 'down'
      # end

      p buttons.cab_call_buttons
      print display.prompt
      while selected_floors = gets.chomp
        # it is 1 || 10
        break if selected_floors == 'c'
        print display.command
        # print selected_floors if error

        formated_request = format_request(selected_floors)
        if formated_request.direction == 'up'
          cab.cab_request_up << Request.new(formated_request.floor, formated_request.direction)
        end
        if formated_request.direction == 'down'
          cab.cab_request_down << Request.new(formated_request.floor, formated_request.direction)
        end

      end

      cab.move_cab
      display.next_command

    end
  end


end

ElevatorController.new(floors: 10).run

# NOTES:
# - I have to have a floor class, no other way to tell the program where the request is coming from




# Command line user
  # [] start the elevator
  # [] Tell the user how many floors in the building - welcome to Troy's Tower
  # [] Tell the elevator where you are
  # [] can make several button calls? figure this out
  # [] Once all buttons have been pushed tell elevator to go

  # Start the elevator
    # [] Cab will start on the 4th floor
    # [] start on the first floor
    # [] user pushes the up button
    # [] makes request for cab
    # [] watch the elvator come down (display, not a big deal to have this)
    # [] the doors will open
    # [] then display the elvator cab buttons
      # [] tell the user they can select as many buttons as they wish (pretending that there are a lot of peeps in the cab)
      # [] assuming no weight limit
      # [] then push door close button
    # [] doors will close
    # [] elevator will drop people off at the floors they need to go to in priorty
    # [] once the last person is off (q is empty)

# TODO - maybe I can have a method called floor. user can type something like
  # floor(1,up) - this would make a request stating, request is coming from floor 1
  # and they want to go up

  # Process starting point
    # [] user can pick witch floor they want to start from again
    # [] depending on where they start display the right hall buttons.
      # [] depending on witch button is selected (up or down, say up) then that is the priorty direction
      # [] if on floor 5 - up button is selected
      # [] floors 2, 1, 6, 4. then the close door button is selected
      # [] UP is priorty
      # [] drop off is in this order:
       # [] UP floor 6,
       # [] then DOWN to floor 4,
       # [] then floor 2,
       # [] then floor 1
       # [] idle
    # then repeat process until quit
    