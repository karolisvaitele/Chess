require_relative 'piece.rb'

class Bishop < Piece
    def initialize(position, color)
        super
        @symbol = "\u2657" if color == "white"
        @symbol = "\u265D" if color == "black"
    end
    def possible_moves(grid)
        moves = []
        x = @x-1
        y = @y-1
        while x>=0 && y>=0
            if valid_path(grid, x, y)
                moves.push([x, y])
                if grid[x][y] != " "
                    break
                end
            else
                break
            end
            x-=1
            y-=1
        end
        x = @x+1
        y = @y-1
        while x<=7 && y>=0
            if valid_path(grid, x, y)
                moves.push([x, y])
                if grid[x][y] != " "
                    break
                end
            else
                break
            end
            x+=1
            y-=1
        end
        x = @x-1
        y = @y+1
        while x>=0 && y<=7
            if valid_path(grid, x, y)
                moves.push([x, y])
                if grid[x][y] != " "
                    break
                end
            else
                break
            end
            x-=1
            y+=1
        end
        x = @x+1
        y = @y+1
        while x<=7 && y<=7
            if valid_path(grid, x, y)
                moves.push([x, y])
                if grid[x][y] != " "
                    break
                end
            else
                break
            end
            x+=1
            y+=1
        end
        moves
    end
end