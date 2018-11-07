class Button
  attr_accessor :illeminate
  attr_reader :cab_call_buttons
  # Need to add door close, and Alarm buttons
  # BUTTONS = %w[1 2 3 4 5 6 7 8 9 10].freeze

  def initialize(args)
    @illeminate = false
    @cab_call_buttons = create_cab_buttons(args[:number_of_floors]).freeze
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

  private

  def create_cab_buttons(floors)
    default_panel = %w[c A]
    panel = (1..floors).to_a
    panel + default_panel
  end
end
