require 'pry'

class ElevatorController
  attr_accessor :cab, :buttons, :quit
  # NOTES you can have lots of elevators so when initilize this will take a arg
  # of how many cars (cabs) GOD

  # Elevator API contract { :floors, :cabs, :type}
  def initialize(*args)
    # need a q
    @number_of_floors = args[0][:floors]
    @cab = Cab.new # can iterate here and create lots of cabs
    @buttons = Button.new(number_of_floors: @number_of_floors)
    @display = Display.new
    @quit = false
  end

  def exit_building
    # BUG if I open the doors to the elevator on the first floor then type q.. busts the code
    if cab.current_floor != 1
      puts `say Please go to first floor, unless you are doing something crazy`
      cab.direction = 'down'
      self.quit = true
    else
      puts 'thanks for visiting Leach Tower'
      exit
    end
  end

  def run
    puts 'You can leave the buiding when ever you like by typing "q"'
    until quit
      quit ? exit : nil
      puts buttons.floor_call_buttons(cab.current_floor)
      action1 = gets.chomp
      exit_building if action1 == 'q'
      cab.direction = action1 == 'u' ? 'up' : 'down'
      # TODO: can not push any numbers above the current floor??? if down call
      buttons.illeminate = true
      Cab.open_doors
      Display.display_current_floor(cab.current_floor)
      p buttons.cab_call_buttons
      cab.destination = gets.chomp.to_i
      Cab.close_doors

      if cab.direction == 'up'
        cab.move_cab_up
      else
        cab.move_cab_down
      end

      Cab.open_doors
      Cab.close_doors
      buttons.illeminate = false
    end
    # I can create the objects in here
    # maybe I can use a struct here maybe
    # pass the current floor
    # puts buttons.floor_call_buttons[Display.numbers_to_name[cab.current_floor]]
    # puts buttons.floor_call_buttons(cab.current_floor)
    # action1 = gets.chomp
    # buttons.illeminate = true if action1.casecmp('u').zero?
    # # I dont think I need to call the class here below
    # Cab.open_doors
    # # needs to be set else where
    # display = cab.current_floor
    # Display.display_current_floor(display)
    # puts "Your current floor is #{display}"
    # p buttons.cab_call_buttons
    # cab.destination = gets.chomp
    # Cab.close_doors
    # cab.move_cab_up
    # Cab.open_doors
    # Cab.close_doors
    # buttons.illeminate = false
    # # I think what might be better is pass the current floor then it will give back the correct call buttons
    # puts buttons.floor_call_buttons(cab.current_floor)
    # # I have to call the elevation
    # # open the doors
    # # display the floor buttons
    # # do something with the destation
    # # should not be any logic here

    # # have to put direction in here so that I know what direction the elevator
    # # is moving to pick up ofther peeps
    # action2 = gets.chomp
    # cab.direction = action2 == 'u' ? 'up' : 'down'

    # # need to figure out what direction they want to go to call the right method

    # Cab.open_doors
    # Display.display_current_floor(cab.current_floor)
    # p buttons.cab_call_buttons
    # cab.destination = gets.chomp.to_i
    # Cab.close_doors

    # if cab.direction = 'up'
    #   cab.move_cab_up
    # else
    #   cab.move_cab_down
    # end

    # Cab.open_doors
    # Cab.close_doors
    # buttons.illeminate = false

    # puts buttons.floor_call_buttons(cab.current_floor)
    # action3 = gets.chomp

    # cab.direction = action3 == 'u' ? 'up' : 'down'
    # Cab.open_doors
    # Display.display_current_floor(cab.current_floor)
    # p buttons.cab_call_buttons
    # cab.destination = gets.chomp.to_i
    # Cab.close_doors
    # cab.move_cab_down
    # Cab.open_doors
    # Cab.close_doors
    # buttons.illeminate = false

    # puts buttons.floor_call_buttons(cab.current_floor)
    # puts 'good bye'
    puts 'Have a great day'
  end
end

class Cab
  attr_accessor :current_floor, :destination, :speed, :direction
  # not sure speed belongs here
  # I think speed belongs to elevator
  # needs to take args WAIT not if speed is moved
  def initialize
    @speed         = 1
    @direction     = nil
    @current_floor = 1
    @destination   = nil
  end

  def self.open_doors
    puts 'Doors opening'
    sleep(2)
  end

  def self.close_doors
    puts 'Doors closing behind you'
    sleep(2)
  end

  def move_cab_up
    # def move_cab(direction)
    # need to do a up and a down
    # TODO: don't say current floor
    # destination = destination.to_i
    current_floor.upto(destination.to_i) do |floor|
      sleep(speed)
      Display.display_current_floor(floor)
    end

    self.current_floor = destination.to_i
  end

  def move_cab_down
    current_floor.downto(destination.to_i) do |floor|
      sleep(speed)
      Display.display_current_floor(floor)
    end
    self.current_floor = destination.to_i
  end
end

class Button
  attr_accessor :illeminate
  attr_reader :cab_call_buttons
  # Need to add door close, and Alarm buttons
  # BUTTONS = %w[1 2 3 4 5 6 7 8 9 10].freeze

  def initialize(args)
    @illeminate = false
    @cab_call_buttons = (1..args[:number_of_floors]).to_a.freeze
  end

  def cab_up
    # move into floor_buttons
    # with direction att
    puts 'Type U for up button'
  end

  def cab_down
    # move into floor_buttons
    puts 'type D for down button'
  end

  def floor_call_buttons(floor)
    # Struct.new do I make a struct here
    # Don't like this
    case floor
    when 1
      '(U) UP'
    when cab_call_buttons.last
      '(D) DOWN'
    else
      ['(U) UP', '(D) DOWN']
    end
    # {
    #   'first' => '(U) UP',
    #   'hall' => ['(U) UP', '(D) DOWN'],
    #   'top' => '(D) DOWN'
    # }
  end

  # def cab_call_buttons
  #   # this lives in the cab_buttons model with att direction
  #   # need to figure out where the floors would live
  #   puts 'Please select a floor'
  #   p BUTTONS
  # end
end

class Display
  # include Display
  def initialize(args = {})
    @display = args[:display]
  end

  def clear_display
    self.display = nil
  end

  def self.display_current_floor(floor)
    display = floor
    `say #{numbers_to_name[floor]} Floor `
  end

  # this goes in the module
  def self.numbers_to_name
    {
      100 => 'hundred',
      90 => 'ninety',
      80 => 'eighty',
      70 => 'seventy',
      60 => 'sixty',
      50 => 'fifty',
      40 => 'forty',
      30 => 'thirty',
      20 => 'twentyth',
      19 => 'nineteenth',
      18 => 'eighteenth',
      17 => 'seventeenth',
      16 => 'sixteenth',
      15 => 'fifteenth',
      14 => 'fourteenth',
      13 => 'thirteenth',
      12 => 'twelveth',
      11 => 'eleventh',
      10 => 'tenth',
      9 => 'ninth',
      8 => 'eighth',
      7 => 'seventh',
      6 => 'sixth',
      5 => 'fifth',
      4 => 'fourth',
      3 => 'third',
      2 => 'second',
      1 => 'first'
    }
  end
end

module Displayable
  # https://github.com/radar/humanize
  def numbers_to_name
    {
      100 => 'hundred',
      90 => 'ninety',
      80 => 'eighty',
      70 => 'seventy',
      60 => 'sixty',
      50 => 'fifty',
      40 => 'forty',
      30 => 'thirty',
      20 => 'twenty',
      19 => 'nineteen',
      18 => 'eighteen',
      17 => 'seventeen',
      16 => 'sixteen',
      15 => 'fifteen',
      14 => 'fourteen',
      13 => 'thirteen',
      12 => 'twelve',
      11 => 'eleven',
      10 => 'ten',
      9 => 'nine',
      8 => 'eight',
      7 => 'seven',
      6 => 'six',
      5 => 'five',
      4 => 'four',
      3 => 'three',
      2 => 'two',
      1 => 'one'
    }
  end
end

# lobby
ElevatorController.new(floors: 20).run
# walk up to button push the up button (the only button)
