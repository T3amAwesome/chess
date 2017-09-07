class PiecesController < ApplicationController
  before_action :next_player, only: [:update]
  
  def show
    @piece = Piece.find(params[:id])
    @current_game = current_game
    redirect_to game_path(@piece.game)
  end

  def update
    @piece = Piece.find(params[:id])
    @piece.move_to!(piece_params["x"].to_i, piece_params["y"].to_i)
    current_game.next_player(@piece.color)
    render json: @piece
  end

  private 

  helper_method :current_game

  def current_game
    @piece = Piece.find(params[:id])
    @current_game ||= @piece.game
  end

  def piece_params
    params.require(:piece).permit(:x, :y)
  end

  def next_player
    @piece = Piece.find(params[:id])
    @game = @piece.game
    @next_player = @piece.opponent
    @game.update_attributes(turn: @next_player)
  end

end
