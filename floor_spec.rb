require_relative 'elevator.rb'
require_relative 'request_queue.rb'

describe 'queue' do
  let(:controller) { ElevatorController.new(floors: 10) }
  let(:floor) { floor.new }

  before do
  end

  it 'expect positive results' do
    expect(q.pop.floor).to eq('first')
  end
end
