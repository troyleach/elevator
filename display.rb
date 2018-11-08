class Display
  # include Display
  def initialize(args = {})
    @display = args[:display]
  end

  def start_elevator
    puts 'Hello and Welcome to Troys tower'
    puts 'This building has 10 Floors'
    puts 'Type "q" at any time to exit this program'
    puts 'We are starting at the looby'
    puts 'There could be one person waiting or 10'
    puts 'Push the "u" to call the elevator to go up'
    puts 'Once the cab arrives the doors will open'
    puts 'Then you will see the elevator buttons'
    puts 'push one or all by typing the number then return'
    puts 'when all the passengers have selected the desired floor push the door close buttons'
    puts 'floor,dirction'
  end

  def clear_display
    self.display = nil
  end

  def self.display_current_floor(floor)
    display = floor
    puts display
    # `say #{numbers_to_name[floor]} Floor`
  end

  def say_current_floor(floor)
    `say #{numbers_to_name[floor]} Floor`
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
