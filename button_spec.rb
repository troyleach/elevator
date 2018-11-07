require 'pry'
require_relative 'button.rb'

describe 'Button class' do
  let(:button) { Button.new(number_of_floors: 10) }

  describe 'On initialization' do
    it 'expect positive results' do
      floors = (1..10).to_a
      default = %w[c A]
      result = floors + default
      expect(button.cab_call_buttons).to eq(result)
    end
  end
end
