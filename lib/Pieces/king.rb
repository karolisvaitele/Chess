require_relative 'piece.rb'

class King < Piece
    def initialize(position, color)
        super
        @symbol = "\u2654" if color == "white"
        @symbol = "\u265A" if color == "black"
    end
    def possible_moves(grid)
        moves = []
        a = -1
        while a<=1
            b = -1
            while b<=1
                x = @x + a
                y = @y + b
                if x<=7 && x>=0 && y<=7 && y>=0 && valid_path(grid, x, y)
                    moves.push([x,y]) if a!=0 || b!=0
                end
                b+=1
            end
            a+=1
        end
        moves
    end
end