require_relative "player.rb"
require_relative "board.rb"
Dir["./Pieces/*.rb"].each {|file| require file}
require 'yaml'

class Game
    attr_accessor :white, :black, :board, :current
    def initialize
        @white = Player.new("White")
        @black = Player.new("Black")
        @board = Board.new
        @current = @white
    end

    def intro
        puts "Hello, welcome to a game of chess."
        puts "To make a move, type in the position of piece you want to move"
        puts "and then the position you want to move it to."
        puts "For example: d2 f3. (Letter first)"
        puts "You can seperate the [from] and [to] inputs with whatever you want"
        puts "as long as it is one character."
        puts "Throughout the game you can save or load game."
        puts "Type save/load to save or load game."
        puts "Typing exit will exit the game"
    end

    def play
        intro if @board.grid[0].any?(nil)
        @board.setup_board if @board.grid[0].any?(nil)
        @board.display_board
        loop do
            turn
            if check?(@board, @current.color)
                puts "############################"
                puts "###{@current.color} has CHECK on #{opposite_color(@current.color)}##"
                puts "############################"
            end
            switch_current
            if game_over?
                break
            end
            @board.display_board
        end
    end

    def game_over?
        if stalemate?
            puts "It's stalemate"
            return true
        elsif checkmate?
            @board.display_board
            puts "######################################"
            puts "##CHECKMATE! #{opposite_color(@current.color)}, Congratulations!##"
            puts "######################################"
            return true
        elsif check?(@board, @current.color)
            @board.display_board
            puts "######################################"
            puts "##CHECKMATE! #{@current.color}, Congratulations!##"
            puts "######################################"
            return true
        end
        return false
    end

    def stalemate?
        moves = @board.get_current_moves(@current.color)
        moves.length == 0
    end

    def check?(board, color)
        moves = board.get_current_moves(color).uniq
        moves.each do |move|
            if board.grid[move[0]][move[1]].class.name == "King" && board.grid[move[0]][move[1]].color == opposite_color(color).downcase
                return true
            end
        end
        return false
    end

    def checkmate?
        pieces = @board.get_pieces(@current.color)
        pieces.each do |piece|
            possible_moves = piece.possible_moves(@board.grid)
            possible_moves.each do |move|
                check_board = Marshal.load(Marshal.dump(@board))
                check_board.move([piece.x, piece.y], move)
                return false if !check?(check_board, opposite_color(@current.color))
            end
        end
        return true
    end

    def turn
        loop do
            puts "#{@current.color}, it's your turn."
            move = gets.chomp
            if valid_input?(move)
                from = [move[1].to_i-1, (move[0].ord - 97)]
                to = [move[4].to_i-1, (move[3].ord)-97]
                if @board.valid_move?(from, to, @current.color)
                    @board.move(from, to)
                    @board.do_promotion(to,@current.color.downcase) if @board.promotion?(to)
                    break
                end
            elsif move.downcase == "save"
                save_game
                next
            elsif move.downcase == "load"
                load_game
            elsif move.downcase == "exit"
                puts "Exiting game..."
                exit
            end
            puts "Enter valid turn."
        end
    end

    def save_game
        loop do 
            puts "Enter filename (if it already exists data will be overridden)."
            @name = gets.chomp
            break if valid_filename?(@name)
            puts "Invalid filename."
        end
        save = File.new("../saved_games/#{@name}.yaml", "w")
        @board.display_board
        data = { board: @board,
                 current: @current,
                 white: @white,
                 black: @black
        }
        save.puts YAML.dump(data)
        save.close
        puts "----------------"
        puts "---Game saved---"
        puts "----------------"
    end

    def load_game
        loop do
            puts "Enter filename of game you want to load (without extension)."
            @name = gets.chomp
            break if File.exist?("../saved_games/#{@name}.yaml")
            puts "Enter existing filename."
        end
        data = YAML.load File.read("../saved_games/#{@name}.yaml")
        load_data(data)
        clear_display
        puts "-----------------"
        puts "---Game loaded---"
        puts "-----------------"
        play
    end

    def load_data(data)
        @board = data[:board]
        @current = data[:current]
        @white = data[:white]
        @black = data[:black]
    end

    def valid_filename?(name)
        unless name =~ /[\/\\\?\%\*\:\|\"\<\>\. ]/
            return true
        end
        return false
    end

    def valid_input?(str)
        str.length == 5 && str[0].downcase.match(/[a-h]/) && str[1].match(/[1-8]/) && str[3].downcase.match(/[a-h]/) && str[4].match(/[1-8]/)
    end

    def switch_current
        if @current == @white
            @current = @black
        else
            @current = @white
        end
    end

    def opposite_color(color)
        if color == "White"
            return "Black"
        else
            return "White"
        end
    end

    def clear_display
        system('clear') || system('clc')
    end
end

game = Game.new
game.play