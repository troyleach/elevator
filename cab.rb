class Cab
  attr_accessor :current_floor,
                :destination,
                :speed,
                # do not think I need direction
                :direction,
                :idle,
                :cab_request_q
  # not sure speed belongs here
  # I think speed belongs to elevator
  # needs to take args WAIT not if speed is moved

  # dir = Struct.new(:current_floor, :destination, :direction)

  def initialize
    @idle           = true
    @speed          = 1
    @direction      = nil
    @current_floor  = 4
    @destination    = nil
    @cab_request_q = RequestQueue.new
  end

  def open_doors
    puts 'Doors opening'
    sleep(2)
  end

  def close_doors
    puts 'Doors closing'
    sleep(2)
  end

  def call_cab(user_input)
    if idle?
      self.direction = user_input.direction
      self.destination = user_input.floor
      self.idle = false
      cab_request_q << Request.new(user_input.floor, user_input.direction)
    else
      # I thiiink...
      # cab_request_q << Request.new(user_input.floor, user_input.direction)
      # ... do some cool things here
    end
    move_cab
  end

  def current_floor?; end

  def format_q
    self.cab_request_q = cab_request_q.group_by
  end

  def move_cab
    format_q
    puts "FUCKER FACE #{direction}"
    # take care of this.. ace the nil guard just put in arrays
    until (cab_request_q['up'].nil? || cab_request_q['up'].empty?) &&
          (cab_request_q['down'].nil? || cab_request_q['down'].empty?)
      if direction == 'up'
        # if cab_request_q.direction == 'up'
        # if direction == 'up' && cab_request_q.direction == 'up'
        move_cab_up
      else
        move_cab_down
      end
      open_doors
      close_doors
    end
    self.idle = true
  end

  def move_cab_up
    destination = cab_request_q['up'].pop.floor
    # destination = cab_request_q.up.pop.floor

    # def move_cab(direction)
    # need to do a up and a down
    # TODO: don't say current floor
    # destination = destination.to_i
    # don't like this floor + 1 stuff
    dispaly_start = current_floor + 1
    dispaly_start.upto(destination) do |floor|
      # dispaly_start.upto(destination.to_i) do |floor|
      sleep(speed)
      Display.display_current_floor(floor)
    end

    self.current_floor = destination
  end

  def move_cab_down
    destination = cab_request_q['down'].pop.floor
    # destination = cab_request_q.down.pop.floor
    # current_floor -= 1 but how would I display?
    display_start = current_floor - 1
    display_start.downto(destination.to_i) do |floor|
      sleep(speed)
      Display.display_current_floor(floor)
    end
    self.current_floor = destination
  end

  private

  def idle?
    idle == true
  end
end
