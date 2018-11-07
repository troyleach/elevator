require 'pry'
require_relative 'cab.rb'
require_relative 'request_queue.rb'
require_relative 'user_input.rb'
require_relative 'display.rb'
# require_relative 'request_queue.rb'

describe 'class Cab' do
  include UserInput
  let(:cab) { Cab.new }

  before do
  end

  describe 'On initialization' do
    it 'expect these attributes' do
      expect(cab.idle).to be(true)
      expect(cab.speed).to eq(1)
      expect(cab.current_floor).to eq(4)
      expect(cab.direction).to be(nil)
      expect(cab.destination).to be(nil)
      expect(cab.cab_request_q).to_not be(nil)
    end
  end

  describe '#move_cab' do
    before do
    end

    describe 'expect DOWN to be the priority' do
      it 'testing' do
        floors = [2, 7, 3, 10]
        test_setup('d', floors)
        binding.pry
      end
    end

    describe 'expect UP to be the priority' do
    end
  end
end

def test_setup(direction, floors)
  cab.direction = direction
  cab.current_floor = 5
  floors.each do |floor|
    formated_request = format_request(floor)
    cab.cab_request_q << Request.new(formated_request.floor, formated_request.direction)
  end
end
