
# Possible things to do:
# -Create "square" struct and convert all dest_x dest_y type args into a struct, with struct.x, struct.y
#   (only if it would make the code cleaner)
# -

class Piece < ApplicationRecord
  
  attr_accessor :x, :y

  def initialize(loc_x, loc_y, game)
    super()
    @x = loc_x
    @y = loc_y
    @game = game
  end
  

  # [From Trello card on move_to!]
  # This method is important and eventually, we will use it in the controller to handle moving pieces.

  # This move_to method should handle the following cases:

  # Check to see if there is a piece in the location it’s moving to.
  # If there is a piece occupying the location, and it is the opposite color, remove the piece from the chess board. This can be done a few different ways.
  # You could have a “status” flag on the piece that will be one of “onboard” or “captured”.
  # You could set the piece’s x/y coordinates to nil
  # You could delete the item from the database.
  # Each solution has pros/cons.
  # If the piece is there and it’s the same color the move should fail - it should either raise an error message or do nothing.
  # It should call update_attributes on the piece and change the piece’s x/y position.
  # Note: This method does not check if a move is valid. We will be using the valid_move? method to do that.
  def move_to!(new_x, new_y)
  # logic here
  end
  
  def is_obstructed?(dest_x, dest_y)

    if is_adjacent?(dest_x, dest_y)
      puts "Invalid destination square in is_obstructed: adjacent square"
      return nil
    end

    if is_horizontal?(dest_x, dest_y)
      range = (x < dest_x) ? (x+1...dest_x) : (dest_x+1...x)
      range.each do |inter_x|
        return true if game.is_occupied?(inter_x, y)
      end
      return false

    elsif is_vertical?(dest_x, dest_y)
      range = (y < dest_y) ? (y+1...dest_y) : (dest_y+1...y)
      range.each do |inter_y|
        return true if game.is_occupied?(x, inter_y)
      end
      return false

    elsif is_diagonal?(dest_x, dest_y)
      range_x = ( (x < dest_x) ? (1...dest_x - x) : (1...x - dest_x) ).to_a
      range_y = ( (y < dest_y) ? (1...dest_y - y) : (1...y - dest_y) ).to_a
      range_x.size.times do |i|
        return true if game.is_occupied?(x+range_x[i], y+range_y[i])
      end
      return false

    else
      puts "Invalid destination square in is_obstructed?"
      return nil
    end
  end

  def is_horizontal?(dest_x, dest_y)
    return y == dest_y
  end

  def is_vertical?(dest_x, dest_y)
    return x == dest_x
  end

  def is_diagonal?(dest_x, dest_y)
    return true if dest_x - x == dest_y - y || dest_x - x == (-1)*(dest_y - y)
    return false
  end

  def is_adjacent?(dest_x, dest_y)
    return true if ((dest_x + dest_y) - (x + y)).abs == 1
    return false
  end

  # Captured piece is denoted by a nil position
  def captured?
    x == nil || y == nil
  end


  private
  
  attr_accessor :game

end
