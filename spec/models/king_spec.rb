require 'rails_helper'

RSpec.describe Piece, type: :king do

  it "should successfully kingside castle with the white king according to the rules of chess" do
    game = Game.create
    game.get_piece_at(6,1).remove_from_game!
    game.get_piece_at(7,1).remove_from_game!
    king = game.pieces.where(type: "King", color: "white").last
    rook = game.pieces.where(type: "Rook", color: "white", x: 8).last
    expect(king.move_to!(7, 1)).to be(true) #castle
    expect(rook.x).to eq(6)
    expect(king.has_moved?).to be(true)
    expect(rook.has_moved?).to be(true)

  end

  # it "should successfully queenside castle with the white king according to the rules of chess" do
  #   game = Game.create
  #   game.get_piece_at(2,1).remove_from_game!
  #   game.get_piece_at(3,1).remove_from_game!
  #   game.get_piece_at(4,1).remove_from_game!
  #   king = game.pieces.where(type: "King", color: "white").last
  #   expect(king.castle!(false)).to be(true)
  #   expect(king.x).to eq(3)
  #   expect(king.has_moved?).to be(true)
  # end

  # it "should successfully kingside castle with the black king according to the rules of chess" do
  #   game = Game.create
  #   game.get_piece_at(6,8).remove_from_game!
  #   game.get_piece_at(7,8).remove_from_game!
  #   king = game.pieces.where(type: "King", color: "black").last
  #   expect(king.castle!(true)).to be(true)
  #   expect(king.x).to eq(7)
  #   expect(king.has_moved?).to be(true)
  # end

  # it "should fail to castle if obstructed" do
  #   game = Game.create
  #   game.get_piece_at(6,1).remove_from_game!
  #   king = game.pieces.where(type: "King", color: "white").last
  #   expect(king.castle!(true)).to be(false)
  #   expect(king.x).to eq(5)
  #   expect(king.has_moved?).to be(false)
  # end

end

