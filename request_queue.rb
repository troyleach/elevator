require 'pry'
#  CabRequest
# group_by(&:direction)
class Request
  include Comparable

  attr_accessor :floor, :priority

  def initialize(floor, priority)
    @floor = floor
    @priority = priority
  end

  def <=>(other)
    other.floor <=> @floor
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
    @requests[0].priority
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

# q = NaivePriorityQueue.new

# q << Element.new('second', 3)
# q << Element.new('last', 100)
# q << Element.new('sixth', 44)
# q << Element.new('first', 1)
# q << Element.new('fifth', 30)
# q << Element.new('fourth', 8)
# q << Element.new('thrid', 7)
