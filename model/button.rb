class Button
  attr_accessor :illeminate
  attr_reader :cab_call_buttons, :number_of_floors

  def initialize(args)
    @illeminate = false
    @number_of_floors = args[:number_of_floors]
    @cab_call_buttons = create_cab_buttons(@number_of_floors).freeze
  end

  def floor_call_buttons(floor)
    case floor
    when 1
      '(U) UP'
    when number_of_floors
      '(D) DOWN'
    else
      ['(U) UP', '(D) DOWN']
    end
  end

  private

  def create_cab_buttons(floors)
    default_panel = %w[c]
    panel = (1..floors).to_a
    panel + default_panel
  end
end
