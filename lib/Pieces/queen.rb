require_relative 'piece.rb'

class Queen < Piece
    def initialize(position, color)
        super
        @symbol = "\u2655" if color == "white"
        @symbol = "\u265B" if color == "black"
    end
    def possible_moves(grid)
        moves = []
        a = -1
        while a<=1
            b = -1
            while b<=1
                x = @x + a
                y = @y + b
                while x>=0 && x<=7 && y>=0 && y<=7 && (a!=0 || b!=0)
                    if valid_path(grid, x, y)
                        moves.push([x, y])
                        if grid[x][y] != " "
                            break
                        end
                    else
                        break
                    end
                    x += a
                    y += b
                end
                b+=1
            end
            a+=1
        end
        moves
    end
end