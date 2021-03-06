class Knight < Piece

  def unicode_point
    color == 'white' ? '&#9816' : '&#9822'
  end

  def valid_move?(dest_x,dest_y)
    super
    return true if ((dest_x - x).abs == 1 && (dest_y - y).abs == 2) || ((dest_x - x).abs == 2 && (dest_y - y).abs == 1)
    return false
  end

end