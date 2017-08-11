class Game < ApplicationRecord

  has_many :pieces

  
  def is_occupied?(x, y)
    return false if get_piece_at(x,y).nil? || get_piece_at(x,y).captured?
    return true
  end

  def get_piece_at(x,y)
    return self.pieces.where(:x => x, :y => y, :game => self).first
  end

end