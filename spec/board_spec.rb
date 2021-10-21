require 'rspec'
require './lib/cell'
require './lib/ship'
require './lib/board'

RSpec.describe Board do
  let(:board) { Board.new }
  describe '#initialize' do
      it 'exists' do
        expect(board).to be_instance_of(Board)
      end

      it 'initally contains an empty hash' do
        expect(board.cells).to eq({})
      end

      
    end

end
