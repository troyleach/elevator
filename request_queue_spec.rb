# request coming in
# I am on the first floor
# I want to go up
require_relative 'request_queue.rb'

describe 'queue' do
  describe 'Cab moving up' do
    let(:q) { RequestQueue.new }

    it 'expect positive results' do
      q << Request.new(2, 'up')
      q << Request.new(7, 'up')
      q << Request.new(6, 'up')
      q << Request.new(1, 'up')
      q << Request.new(5, 'up')
      q << Request.new(4, 'up')
      q << Request.new(3, 'up')

      expect(q.empty?).to be(false)
      expect(q.pop.floor).to eq(1)
      expect(q.pop.floor).to eq(2)
      expect(q.pop.floor).to eq(3)
      expect(q.pop.floor).to eq(4)
      expect(q.pop.floor).to eq(5)
      expect(q.pop.floor).to eq(6)
      expect(q.pop.floor).to eq(7)
    end

    it 'expect positive results' do
      q << Request.new(4, 'up')
      q << Request.new(3, 'up')
      q << Request.new(5, 'up')
      q << Request.new(2, 'up')

      expect(q.empty?).to be(false)
      expect(q.pop.floor).to eq(2)
      expect(q.pop.floor).to eq(3)
      expect(q.pop.floor).to eq(4)
      expect(q.pop.floor).to eq(5)
    end
  end

  describe 'Cab moving down' do
    let(:q) { RequestQueue.new }
    it 'expect positive results' do
      q << Request.new(4, 'dn')
      q << Request.new(3, 'dn')
      q << Request.new(5, 'dn')
      q << Request.new(2, 'dn')

      expect(q.empty?).to be(false)
      expect(q.pop.floor).to eq(5)
      expect(q.pop.floor).to eq(4)
      expect(q.pop.floor).to eq(3)
      expect(q.pop.floor).to eq(2)
    end
  end

end
