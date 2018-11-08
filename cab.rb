class Cab
  attr_accessor :current_floor,
                :destination,
                :speed,
                # do not think I need direction
                :direction,
                :idle,
                :cab_request_up,
                :cab_request_down,
                :display
  # not sure speed belongs here
  # I think speed belongs to elevator
  # needs to take args WAIT not if speed is moved

  # dir = Struct.new(:current_floor, :destination, :direction)

  def initialize
    @idle             = true
    @speed            = 1
    @direction        = nil
    @current_floor    = 4
    @destination      = nil
    @cab_request_up   = RequestQueue.new(priority_direction: 'up')
    @cab_request_down = RequestQueue.new(priority_direction: 'down')
    # @cab_request_q =
    #   { 'up' => RequestQueue.new,
    #     'down' => RequestQueue.new }
    @display = Display.new
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
      if direction == 'down'
        cab_request_down << Request.new(user_input.floor, user_input.direction)
      else
        cab_request_up << Request.new(user_input.floor, user_input.direction)
      end
      # I thiiink...
      # cab_request_q << Request.new(user_input.floor, user_input.direction)
      # ... do some cool things here
    end
    move_cab
  end

  def current_floor?; end

  # def format_q
  #   self.cab_request_q = cab_request_q.group_by
  # end

  def operate_cap(user_input)
    if idle?
      self.direction = user_input.direction
      self.destination = user_input.floor
      self.idle = false
      if direction == 'down'
        cab_request_down << Request.new(user_input.floor, user_input.direction)
      else
        cab_request_up << Request.new(user_input.floor, user_input.direction)
      end
      # I thiiink...
      # cab_request_q << Request.new(user_input.floor, user_input.direction)
      # ... do some cool things here
    end
    move_cab
  end
  # operate

  def move_cab
    # format_q
    close_doors if idle?
    # close_doors I think the doors would already be closed
    puts "FUCKER FACE priority => #{direction}"
    # binding.pry
    # take care of this.. ace the nil guard just put in arrays

    # until cab_request_up.nil? && cab_request_down.empty?
      if direction == 'up'
        # Go this direction until the box is empty
        # if cab_request_q.direction == 'up'
        # if direction == 'up' && cab_request_q.direction == 'up'
        move_cab_up
      else
        # OR Go this direction until the box is empty
        move_cab_down
      end
    # end

    # self.cab_request_q = RequestQueue.new
    self.destination = nil
    self.idle = true
  end

  def set_priority; end

  def move_cab_up
    until cab_request_up.nil? || cab_request_up.empty?
      destination = cab_request_up.pop.floor
      puts "DESTINATION => #{destination}"
      dispaly_start = current_floor + 1
      dispaly_start.upto(destination) do |floor|
        # dispaly_start.upto(destination.to_i) do |floor|
        sleep(speed)
        Display.display_current_floor(floor)
      end
      display.say_current_floor(destination)
      self.current_floor = destination
      open_doors
      puts '...Loading'
      close_doors if idle?
    end
    # destination = cab_request_q.up.pop.floor

    # def move_cab(direction)
    # need to do a up and a down
    # TODO: don't say current floor
    # destination = destination.to_i
    # don't like this floor + 1 stuff

    self.current_floor = destination
  end

  def move_cab_down
    until cab_request_down.nil? || cab_request_down.empty?
      destination = cab_request_down.pop.floor
      puts "DESTINATION => #{destination}"
      # destination = cab_request_q.down.pop.floor
      # current_floor -= 1 but how would I display?
      display_start = current_floor - 1
      display_start.downto(destination.to_i) do |floor|
        sleep(speed)
        Display.display_current_floor(floor)
      end
      display.say_current_floor(destination)
      self.current_floor = destination
      open_doors
      puts '...Loading'
      close_doors if idle?
    end
    self.current_floor = destination
  end

  private

  def idle?
    idle == true
  end
end
