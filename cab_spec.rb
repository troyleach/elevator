require 'pry'
require_relative 'cab.rb'
# require_relative 'request_queue.rb'

describe 'class Cab' do
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
end
