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
    @current_floor  = 2
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

  def call_cab
    # not sure this is the best place for this
    self.idle = false
    move_cab_down
    # if the cab is on 4 and I am on 1
  end

  def current_floor?; end

  def move_cab
    until cab_request_q.empty?
      if cab_request_q.direction == 'up'
        # if direction == 'up' && cab_request_q.direction == 'up'
        move_cab_up
      else
        move_cab_down
      end
      open_doors
      close_doors
    end
  end

  def move_cab_up
    destination = cab_request_q.pop.floor
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
    destination = cab_request_q.pop.floor
    # destination = cab_request_q.down.pop.floor
    # current_floor -= 1 but how would I display?
    display_start = current_floor - 1
    display_start.downto(destination.to_i) do |floor|
      sleep(speed)
      Display.display_current_floor(floor)
    end
    self.current_floor = destination
  end
end
