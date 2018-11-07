require 'pry'
#  CabRequest
# group_by(&:direction)
class Request
  include Comparable

  attr_accessor :floor, :direction

  def initialize(floor, direction)
    @floor = floor
    @direction = direction
  end

  # def <=>(other)
  #   other.floor <=> @floor
  # end
  def <=>(other)
    if @direction == 'up'
      other.floor <=> @floor
    else
      @floor <=> other.floor
    end
  end
end

class RequestQueue
  def initialize
    @requests = []
  end

  def <<(request)
    @requests << request
  end

  def direction
    @requests[0].direction
  end

  def group_by
    @requests.group_by(&:direction)
  end

  def pop
    last_request_index = @requests.size - 1
    @requests.sort!
    @requests.delete_at(last_request_index)
  end

  def empty?
    @requests.empty?
  end
end
