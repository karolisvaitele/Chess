Dir["./Pieces/*.rb"].each {|file| require file}

class Board
    attr_accessor :grid
    def initialize
        @grid = Array.new(8) {Array.new(8)}
    end

    def setup_board
        8.times do |i|
            8.times do |j|
                @grid[i][j] = " "
            end
        end
        8.times do |i|
            @grid[6][i] = Pawn.new([6,i],"white")
            @grid[1][i] = Pawn.new([1,i],"black")
            case i
            when 0
                @grid[7][i] = Rook.new([7,i],"white")
                @grid[7][7-i] = Rook.new([7,7-i],"white")
                @grid[0][i] = Rook.new([0,i],"black")
                @grid[0][7-i] = Rook.new([0,7-i],"black")
            when 1
                @grid[7][i] = Knight.new([7,i],"white")
                @grid[7][7-i] = Knight.new([7,7-i],"white")
                @grid[0][i] = Knight.new([0,i],"black")
                @grid[0][7-i] = Knight.new([0,7-i],"black")
            when 2
                @grid[7][i] = Bishop.new([7,i],"white")
                @grid[7][7-i] = Bishop.new([7,7-i],"white")
                @grid[0][i] = Bishop.new([0,i],"black")
                @grid[0][7-i] = Bishop.new([0,7-i],"black")
            when 3
                @grid[7][i] = Queen.new([7,i],"white")
                @grid[7][7-i] = King.new([7,7-i],"white")
                @grid[0][i] = Queen.new([0,i],"black")
                @grid[0][7-i] = King.new([0,7-i],"black")
            end
        end
    end

    def display_board
        puts
        print "  "
        8.times do |i|
            print "#{(97+i).chr} "
        end
        puts
        print " \u250C"
        7.times do 
            print "\u2500"
            print "\u252C"
        end
        print "\u2500"
        print "\u2510"
        puts
        16.times do |i|
            print "#{i/2+1}\u2502" if i%2==0
            print " \u251C" if i%2!=0 && i!=15
            print " \u2514" if i==15
            8.times do |j|
                if i%2==0
                    piece = @grid[i/2][j]
                    if piece == nil || piece == " "
                        print " "
                    else
                        print piece.symbol
                    end
                    print "\u2502"
                else
                    print "\u2500"
                    print "\u253C" if j!=7 && i!=15
                    print "\u2534" if j!=7 && i==15
                    print "\u2524" if j==7 && i!=15
                    print "\u2518" if j==7 && i==15
                end
            end
            puts
        end
    end

    def move(from, to)
        @grid[from[0]][from[1]].update_pos(to)
        @grid[to[0]][to[1]] = @grid[from[0]][from[1]]
        @grid[from[0]][from[1]] = " "
    end

    def valid_move?(from, to, color)
        if @grid[from[0]][from[1]] != " " && from.all? {|x| x<=7 && x>=0} && to.all? {|x| x<=7 && x>=0} && color.downcase == @grid[from[0]][from[1]].color
            return @grid[from[0]][from[1]].possible_moves(@grid).include?(to)
        else
            return false
        end
    end

    def get_pieces(color)
        pieces = []
        @grid.each do |sub_arr|
            (pieces << sub_arr.select{|x| x!=" " && x.color==color.downcase}).flatten!
        end
        pieces
    end

    def get_current_moves(color)
        pieces = get_pieces(color)
        moves = []
        pieces.each do |piece|
            possible_moves = piece.possible_moves(@grid)
            possible_moves.each do |move|
                moves<<move
            end
        end
        moves
    end

    def promotion?(position)
        (position[0] == 7 || position[0] == 0) && @grid[position[0]][position[1]].class.is_a?(Pawn)
    end

    def do_promotion(position, color)
        if @grid[position[0]][position[1]].class.is_a?(Pawn)
            loop do
                puts "#{color}, your pawn can be promoted."
                puts "Enter r/k/b/q respectively to promote to Rook, Knight, Bishop or Queen"
                choice = gets.chomp
                if choice.length == 1 && choice.downcase.match(/[rkbq]/)
                    break
                end
                puts "Please, enter valid choice."
            end
            case choice.downcase
            when "r"
                @grid[position[0]][position[1]] = Rook.new(position,color.downcase)
            when "k"
                @grid[position[0]][position[1]] = Knight.new(position,color.downcase)
            when "b"
                @grid[position[0]][position[1]] = Bishop.new(position,color.downcase)
            when "q"
                @grid[position[0]][position[1]] = Queen.new(position,color.downcase)
            end
        end
    end
end