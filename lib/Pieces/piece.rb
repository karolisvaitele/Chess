class Piece
    attr_reader :color, :symbol
    attr_accessor :x, :y
    def initialize(position, color)
        @color = color
        @x = position[0]
        @y = position[1]
    end

    def valid_path(grid, x, y)
        return true if grid[x][y] == " " || grid[x][y] == nil
        if grid[x][y].color == @color
            return false
        end
        return true
    end

    def update_pos(coord)
        @x = coord[0]
        @y = coord[1]
    end
end