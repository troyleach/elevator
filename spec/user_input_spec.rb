require 'pry'
require_relative '../lib/user_input.rb'
require_relative '../model/cab.rb'
include UserInput

describe 'module UserInput format users input' do
  describe 'return error message' do
    it 'expect a error message' do
      result = format_request('asdf')
      expect(result).to eq('error')
    end
  end

  describe 'return the correct direction' do
    it 'expect positive result for up' do
      result = format_request('u')
      expect(result).to eq('up')
    end

    it 'expect positive result for down' do
      result = format_request('d')
      expect(result).to eq('down')
    end
  end

  describe 'return the correct UserRequest Struct' do
    # Current floor of cab is 4 by default
    let(:cab) { Cab.new }
    it 'If user enters 1' do
      result = format_request('1')
      expect(result.floor).to eq(1)
      expect(result.direction).to eq('down')
    end

    it 'If user enters 6' do
      result = format_request('6')
      expect(result.floor).to eq(6)
      expect(result.direction).to eq('up')
    end
  end
end
