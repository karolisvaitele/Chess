require_relative 'piece.rb'

class Knight < Piece
    def initialize(position, color)
        super
        @symbol = "\u2658" if color == "white"
        @symbol = "\u265E" if color == "black"
    end
    def possible_moves(grid)
        moves = []
        x = @x-2
        y = @y-1
        moves.push([x,y]) if x>=0 && y>=0 && valid_path(grid, x, y)
        x = @x+2
        y = @y-1
        moves.push([x,y]) if x<=7 && y>=0 && valid_path(grid, x, y)
        x = @x-2
        y = @y+1
        moves.push([x,y]) if x>=0 && y<=7 && valid_path(grid, x, y)
        x = @x+2
        y = @y+1
        moves.push([x,y]) if x<=7 && y<=7 && valid_path(grid, x, y)
        x = @x-1
        y = @y-2
        moves.push([x,y]) if x>=0 && y>=0 && valid_path(grid, x, y)
        x = @x+1
        y = @y-2
        moves.push([x,y]) if x<=7 && y>=0 && valid_path(grid, x, y)
        x = @x-1
        y = @y+2
        moves.push([x,y]) if x>=0 && y<=7 && valid_path(grid, x, y)
        x = @x+1
        y = @y+2
        moves.push([x,y]) if x<=7 && y<=7 && valid_path(grid, x, y)
        moves
    end
end