require_relative 'piece.rb'

class Pawn < Piece
    def initialize(position, color)
        super
        @symbol = "\u2659" if color == "white"
        @symbol = "\u265F" if color == "black"
    end
    def possible_moves(grid)
        moves = []
        if @color == "white" && @x-1 >= 0 && valid_path(grid, @x-1, @y)
            moves.push([@x-1, @y])
            if @x == 6 && valid_path(grid, @x-2, @y)
                moves.push([@x-2, @y])
            end
        end
        if @color == "black" && @x+1 <= 7 && valid_path(grid, @x+1, @y)
            moves.push([@x+1, @y ])
            if @x == 1 && valid_path(grid, @x+2, @y)
                moves.push([@x+2, @y])
            end
        end
        if @color == "white" && @x-1 >= 0
            moves.push([@x-1, @y-1]) if valid_path(grid, @x-1, @y-1) && grid[@x-1][@y-1] != " "
            moves.push([@x-1, @y+1]) if valid_path(grid, @x-1, @y+1) && grid[@x-1][@y+1] != " "
        end
        if @color == "black" && @x+1 <= 7
            moves.push([@x+1, @y-1]) if valid_path(grid, @x+1, @y-1) && grid[@x+1][@y-1] != " "
            moves.push([@x+1, @y+1]) if valid_path(grid, @x+1, @y+1) && grid[@x+1][@y+1] != " "
        end
        moves
    end
end