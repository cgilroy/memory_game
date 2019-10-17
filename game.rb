require_relative('board')
require_relative('HumanPlayer')
require_relative('ComputerPlayer')

class Game
    def initialize
        @board = Board.new
        @last_guess = ''
        @player = ComputerPlayer.new
    end

    def play
        until self.over? do
            system("clear")
            @board.render
            guess = @player.get_guess(@last_guess)
            self.check_guess(guess)
        end
        system("clear")
        @board.render
        puts "You win!"
    end

    def check_guess(current_guess)
        @board[current_guess].reveal
        @player.receive_revealed_card(current_guess,@board[current_guess].to_s)
        if @last_guess == ''
            @last_guess = current_guess
        else    
            system('clear')
            @board.render
            if @board[current_guess] != @board[@last_guess]
                puts 'Try again.'
                @board[@last_guess].hide
                @board[current_guess].hide
            else
                @player.receive_match(@last_guess,current_guess)
            end
            sleep(1)
            @last_guess = ''
        end
    end

    def over?
        (0..3).each do |row|
            (0..3).each do |col|
                return false if @board[row.to_s+','+col.to_s].face_up == false
            end
        end
        true
    end
end

x = Game.new
x.play