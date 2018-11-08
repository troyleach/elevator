class Display
  def initialize(args = {})
    @display = args[:display]
    @floors = args[:floors]
    @current_floor = args[:current_floor]
  end

  def start_elevator
    puts 'Hello and Welcome to Troys Tower'
    puts "This building has #{floors} Floors"
    puts "Current Location of Elevator is Floor #{current_floor}"
    puts 'To start just type the floor you are on (1 - 10)'
    puts 'After you type then number (1-10) and hit the return key you will see'
    puts "Either [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 'c'] (this represents the floor buttons OR"
    puts 'You will see:'
    puts '(U) UP'
    puts '(D) DOWN'
    puts "At this time select 'u' or 'd' and hit the return key, the buttons from above will appear"
    puts 'You can select as many buttons as you wish by simply typing a number (1-10) then hit the return key'
    puts 'Continue with this until all the passengers have selected thier desired floors'
    puts "then type 'c' and hit return"
    puts 'This will close the doors and you will be on your way'
    puts "Type 'q' at any time to exit this program"
  end

  def self.display_current_floor(floor)
    display = floor
    puts display
    # `say #{numbers_to_name[floor]} Floor`
  end

  def say_current_floor(floor)
    `say #{numbers_to_name[floor]} Floor`
  end

  def prompt
    print 'q: quit, number, c: close door =>  '
  end

  # this goes in the module
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

  private

  attr_reader :floors, :current_floor
end
