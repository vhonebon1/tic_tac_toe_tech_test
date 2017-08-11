require 'game'

describe Game do

  let(:board) { double(grid: ['-', '-', '-','-', '-', '-', '-', '-', '-']) }
  let(:second_board) { double(grid: [':x', '-', '-',':x', '-', '-', '-', '-', '-']) }

  let(:player1) { double(symbol: :x) }
  let(:player2) { double(symbol: :o) }
  let(:game) { described_class.new(board, player1, player2) }
  let(:second_game) { described_class.new(second_board, player1, player2) }


  describe '#initialize' do
    it 'initializes with a board' do
      expect(game.board).to_not eq(nil)
    end

    it 'initializes with two players' do
      expect(game.players.length).to eq(2)
    end

    it 'player1 starts as the current player' do
      expect(game.current_player).to eq(player1)
    end
  end

  before do
    allow(board).to receive(:space_is_free?).with(0).and_return(true)
    allow(board).to receive(:winning_move?).and_return(false)
    allow(board).to receive(:print)
  end

  describe '#make_move' do
    it 'allows a player to make a move' do
      game.make_move(0)
      expect(game.board.grid[0]).to eq(:x)
    end

    it 'switches the current player after a move' do
      game.make_move(0)
      expect(game.current_player).to eq(player2)
    end

    it 'allows players to take alternate turns' do
      game.make_move(0)
      allow(board).to receive(:space_is_free?).with(1).and_return(true)
      game.make_move(1)
      expect(game.board.grid[1]).to eq(:o)
    end

    it 'allows a player to pick a free space only' do
      game.make_move(0)
      allow(board).to receive(:space_is_free?).with(0).and_return(false)
      expect { game.make_move(0) }.to raise_error('Space taken!')
    end

    it 'tells the players if there is a winner' do
      allow(second_board).to receive(:space_is_free?).with(6).and_return(true)
      allow(second_board).to receive(:winning_move?).and_return(true)
      allow(second_board).to receive(:print).and_return('board')
      expect { second_game.make_move(6) }.to output("Win!\n").to_stdout
    end
  end
end
