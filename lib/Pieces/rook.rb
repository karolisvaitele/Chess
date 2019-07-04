require_relative 'piece.rb'

class Rook < Piece
    def initialize(position, color)
        super
        @symbol = "\u2656" if color == "white"
        @symbol = "\u265C" if color == "black"
    end
    def possible_moves(grid)
        moves = []
        x = @x-1
        while x>=0
            if valid_path(grid, x, @y)
                moves.push([x, @y])
                if grid[x][@y] != " "
                    break
                end
            else
                break
            end
            x-=1
        end
        x = @x+1
        while x<=7
            if valid_path(grid, x, @y)
                moves.push([x, @y])
                if grid[x][@y] != " "
                    break
                end
            else
                break
            end
            x+=1
        end
        y = @y-1
        while y>=0
            if valid_path(grid, @x, y)
                moves.push([@x, y])
                if grid[@x][y] != " "
                    break
                end
            else
                break
            end
            y-=1
        end
        y = @y+1
        while y<=7
            if valid_path(grid, @x, y)
                moves.push([@x, y])
                if grid[@x][y] != " "
                    break
                end
            else
                break
            end
            y+=1
        end
        moves
    end
end