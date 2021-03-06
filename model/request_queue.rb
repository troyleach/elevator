class Request
  include Comparable

  attr_accessor :floor, :direction

  def initialize(floor, direction)
    @floor = floor
    @direction = direction
  end

  def <=>(other)
    other.floor <=> @floor
  end
end

class RequestQueue
  def initialize(args)
    @requests = []
    @priority_direction = args[:priority_direction]
  end

  def <<(request)
    @requests << request
  end

  def direction
    @requests[0].direction
  end

  def any?
    @requests.any?
  end

  def empty?
    @requests.empty?
  end

  def pop
    last_request_index = @requests.size - 1
    @requests.sort!
    @requests.reverse! if @priority_direction == 'down'
    @requests.delete_at(last_request_index)
  end
end
