require 'pry'
require_relative 'request_queue.rb'
require_relative 'cab.rb'
require_relative 'button.rb'
require_relative 'user_input.rb'
require_relative 'display.rb'

class ElevatorController
  include UserInput
  attr_accessor :cab, :buttons, :quit, :floor
  attr_reader :display, :top_floor, :bottom_floor
  # attr_accessor :cab, :buttons, :quit
  # NOTES you can have lots of elevators so when initilize this will take a arg
  # of how many cars (cabs) GOD

  # Elevator endpoint contract { :floors, :cabs, :type}
  def initialize(*args)
    # @number_of_floors = args[0][:floors]
    @top_floor = args[0][:floors]
    @bottom_floor = 1
    # need a q
    @cab = Cab.new # can iterate here and create lots of cabs
    @buttons = Button.new(number_of_floors: @top_floor)
    # I think I can remove this from here the display
    @display = Display.new
    @quit = false
    #dont this is needed
    # @floor = Struct.new(:request_floor, :destination_floor, :direction)
    @floor = nil
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

  def validate_user_input(input)

  end

  def run
    display.start_elevator
    #move below
    puts "what floor are you starting on? This building has #{top_floor} floors"
    puts 'Just enter a number'
    puts "Current location of Elevator #{cab.current_floor}"
    # puts buttons.floor_call_buttons(1) they can enter what ever they want
    until quit
      puts 'AT THE VERY TOP'
      # quit ? exit : nil
      # exit_building if gets.chomp == 'q'
      input = format_request(gets.chomp)
      cab.operate_cap(input)







      # 1 through 10 in this skeme 1 is down and 10 is up bc of the current_position of the elev
      # U || D

      # direction_key = {
      #   top_floor.to_s => 'down',
      #   bottom_floor.to_s => 'up',
      #   'u' => 'up',
      #   'd' => 'down'
      # }


      # SKIP
      # If not 1 or 10 - Not sure this goes here
        # it is U || D
      if input.floor != bottom_floor && input.floor != top_floor
        puts "in Elevator not 1 or 10 #{input}"
        direction_key = {
          top_floor.to_s => 'down',
          bottom_floor.to_s => 'up',
          'u' => 'up',
          'd' => 'down'
        }
        puts buttons.floor_call_buttons(floor)
        dir = gets.chomp
        cab.direction = direction_key[dir]
        puts " in elevator cab.direction #{cab.direction}"
        # cab.cab_request_q << Request.new(input.floor, input.direction)
        # if input.floor == cab.current_floor
        # end
      end
      # SKIP


      puts 'AFTER THE FLOOR IS NOT 1 OR 10'

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
      while selected_floors = gets.chomp
        # it is 1 || 10
        break if selected_floors == 'c'

        formated_request = format_request(selected_floors)
        # TODO this needs to be fixed hard coded up also needs to be moved to one place
        if formated_request.direction == 'up'
          cab.cab_request_up << Request.new(formated_request.floor, formated_request.direction)
        end
        if formated_request.direction == 'down'
          cab.cab_request_down << Request.new(formated_request.floor, formated_request.direction)
        end

      end
      



      # puts "prioridty direction => #{direction_key[input.floor.to_s]}"
      # cab.direction = "up"
      # cab.direction = "down"
      cab.move_cab




      puts 'AT THE VERY END BEFORE HEADING BACK TO THE TOP'
      puts 'what floor are you on now?'

      # cab.move_cab
      # cab.cab_request_q << Request.new(input.floor, input.direction)
      
      # # how will I keep them from entering 6,up if they pushed the down button, maybe I don't, it will just fall in the q or it wont go anywhere like the elevators do
      # cab.call_cab
      # cab.open_doors

      # # input = gets.chomp.split(',')
      # while input = gets.chomp
      #   break if input == 'c'

      #   formated_request = format_request(input)
      #   cab.cab_request_q << Request.new(formated_request.floor, formated_request.direction)
      # end

      # cab.close_doors
      # cab.move_cab

      # floor == 1 ? 'up' : cab.direction = gets.chomp.downcase

      # request = gets.chomp.split(',')
      # cab.cab_request_q << Request.new

      # where is the passenger
      # then move cab to me
      # if the cab is idel
        # send it down
      # otherwise put this request in the q





      #this does not work??? this assumes the cab is on the same floor
      # things I need to know for requests.
        # The floor that the request is being made from
        # up or down
      # maybe not do a priorty Q - just sort the numbers.. so it going up
      # sort, then when at the last of the ups... do downs


      # {
      #   up: [Array of up objects {from to}],
      #   down: [Array of down objects {from to}]
      # }
      # depending on the direciton the elevator is already heading go that direction
      # if the elevator is idle go tothe closet floor then depending on the direction
      # go that direction
      # cab.direction = action1 == 'u' ? 'up' : 'down'
      # # TODO: can not push any numbers above the current floor??? if down call
      # buttons.illeminate = true
      # Cab.open_doors
      # Display.display_current_floor(cab.current_floor)
      # p buttons.cab_call_buttons
      # cab.destination = gets.chomp.to_i
      # Cab.close_doors

      # if cab.direction == 'up'
      #   cab.move_cab_up
      # else
      #   cab.move_cab_down
      # end

      # Cab.open_doors
      # Cab.close_doors
      # buttons.illeminate = false
    end
    puts 'Have a great day'
  end

  private

  def exit_building
    # I think I can make this just quit.
    # BUG if I open the doors to the elevator on the first floor then type q..
    # busts the code
    if cab.current_floor != 1
      puts `say Please go to first floor, unless you are doing something crazy`
      cab.direction = 'down'
      self.quit = true
    else
      puts 'thanks for visiting Leach Tower'
      exit
    end
    false
  end

  def quit?
    quit == 'q'
  end

  def top?
    self.floor = top_floor
  end

  def lobby?
    self.floor = bottom_floor
  end

end

# class Cab
#   attr_accessor :current_floor, :destination, :speed, :direction
#   # not sure speed belongs here
#   # I think speed belongs to elevator
#   # needs to take args WAIT not if speed is moved

#   # dir = Struct.new(:current_floor, :destination, :direction)

#   def initialize
#     @idle           = true
#     @speed          = 1
#     @direction      = nil
#     @current_floor  = 4
#     @destination    = nil
#     @cab_requests_q = [
#       up: [],
#       down: []
#     ]
#   end

#   def self.open_doors
#     puts 'Doors opening'
#     sleep(2)
#   end

#   def self.close_doors
#     puts 'Doors closing behind you'
#     sleep(2)
#   end

#   def cab
#     if self.idle
#       move_cab_down
#     end
#     # if the cab is onn 4 and I am on 1
#   end

#   def current_floor?; end

#   def move_cab_up
#     # def move_cab(direction)
#     # need to do a up and a down
#     # TODO: don't say current floor
#     # destination = destination.to_i
#     dispaly_start = current_floor + 1
#     dispaly_start.upto(destination.to_i) do |floor|
#       sleep(speed)
#       # don't like this floor - 1 stuff
#       Display.display_current_floor(floor)
#     end

#     self.current_floor = destination.to_i
#   end

#   def move_cab_down
#     # current_floor -= 1 but how would I display?
#     display_start = current_floor - 1
#     display_start.downto(destination.to_i) do |floor|
#       sleep(speed)
#       Display.display_current_floor(floor)
#     end
#     self.current_floor = destination.to_i
#   end
# end

# class Button
#   attr_accessor :illeminate
#   attr_reader :cab_call_buttons
#   # Need to add door close, and Alarm buttons
#   # BUTTONS = %w[1 2 3 4 5 6 7 8 9 10].freeze

#   def initialize(args)
#     @illeminate = false
#     @cab_call_buttons = create_cab_buttons(args[:number_of_floors]).freeze
#   end

#   def floor_call_buttons(floor)
#     # Struct.new do I make a struct here
#     # Don't like this
#     case floor
#     when 1
#       '(U) UP'
#     when cab_call_buttons.last
#       '(D) DOWN'
#     else
#       ['(U) UP', '(D) DOWN']
#     end
#     # {
#     #   'first' => '(U) UP',
#     #   'hall' => ['(U) UP', '(D) DOWN'],
#     #   'top' => '(D) DOWN'
#     # }
#   end

#   private

#   def create_cab_buttons(floors)
#     default_panel = %w[c A]
#     panel = (1..floors).to_a
#     default_panel + panel
#   end
# end

# class Display
#   # include Display
#   def initialize(args = {})
#     @display = args[:display]
#   end

#   def start_elevator
#     puts 'Hello and Welcome to Troys tower'
#     puts 'This building has 10 Floors'
#     puts 'Type "q" at any time to exit this program'
#     puts 'We are starting at the looby'
#     puts 'There could be one person waiting or 10'
#     puts 'Push the "u" to call the elevator to go up'
#     puts 'Once the cab arrives the doors will open'
#     puts 'Then you will see the elevator buttons'
#     puts 'push one or all by typing the number then return'
#     puts 'when all the passengers have selected the desired floor push the door close buttons'
#     puts 'floor,dirction'
#   end

#   def clear_display
#     self.display = nil
#   end

#   def self.display_current_floor(floor)
#     display = floor
#     `say #{numbers_to_name[floor]} Floor`
#   end

#   # this goes in the module
#   def self.numbers_to_name
#     {
#       100 => 'hundred',
#       90 => 'ninety',
#       80 => 'eighty',
#       70 => 'seventy',
#       60 => 'sixty',
#       50 => 'fifty',
#       40 => 'forty',
#       30 => 'thirty',
#       20 => 'twentyth',
#       19 => 'nineteenth',
#       18 => 'eighteenth',
#       17 => 'seventeenth',
#       16 => 'sixteenth',
#       15 => 'fifteenth',
#       14 => 'fourteenth',
#       13 => 'thirteenth',
#       12 => 'twelveth',
#       11 => 'eleventh',
#       10 => 'tenth',
#       9 => 'ninth',
#       8 => 'eighth',
#       7 => 'seventh',
#       6 => 'sixth',
#       5 => 'fifth',
#       4 => 'fourth',
#       3 => 'third',
#       2 => 'second',
#       1 => 'first'
#     }
#   end
# end


# module Displayable
#   # https://github.com/radar/humanize
#   def numbers_to_name
#     {
#       100 => 'hundred',
#       90 => 'ninety',
#       80 => 'eighty',
#       70 => 'seventy',
#       60 => 'sixty',
#       50 => 'fifty',
#       40 => 'forty',
#       30 => 'thirty',
#       20 => 'twenty',
#       19 => 'nineteen',
#       18 => 'eighteen',
#       17 => 'seventeen',
#       16 => 'sixteen',
#       15 => 'fifteen',
#       14 => 'fourteen',
#       13 => 'thirteen',
#       12 => 'twelve',
#       11 => 'eleven',
#       10 => 'ten',
#       9 => 'nine',
#       8 => 'eight',
#       7 => 'seven',
#       6 => 'six',
#       5 => 'five',
#       4 => 'four',
#       3 => 'three',
#       2 => 'two',
#       1 => 'one'
#     }
  # end
# end

# lobby
ElevatorController.new(floors: 10).run
# walk up to button push the up button (the only button)

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
    