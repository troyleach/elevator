require 'pry'
require_relative '../model/button.rb'

describe 'Button class' do
  let(:button) { Button.new(number_of_floors: 10) }

  describe 'On initialization' do
    it 'expect positive results' do
      floors = (1..10).to_a
      default = %w[c]
      result = floors + default
      expect(button.cab_call_buttons).to eq(result)
    end
  end

  describe '#floor_call_buttons' do
    it 'when floor one' do
      expectation = '(U) UP'
      expect(button.floor_call_buttons(1)).to eq(expectation)
    end

    it 'when last floor' do
      expectation = '(D) DOWN'
      expect(button.floor_call_buttons(10)).to eq(expectation)
    end

    it 'when any of 2 - 9 floors' do
      expectation = ['(U) UP', '(D) DOWN']
      expect(button.floor_call_buttons(3)).to eq(expectation)
    end
  end
end
