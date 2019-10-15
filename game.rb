require_relative('board')

class Game
    def initialize
        @board = Board.new
        @last_guess = ''
    end

    def play
        until self.over? do
            system("clear")
            @board.render
            guess = self.get_guess
            self.check_guess(guess)
        end
        system("clear")
        @board.render
        puts "You win!"
    end

    def get_guess
        puts "Please enter your guess e.g. '1,3'"
        gets.chomp
    end

    def check_guess(current_guess)
        @board[current_guess].reveal
        if @last_guess == ''
            @last_guess = current_guess
        else    
            if @board[current_guess] != @board[@last_guess]
                system('clear')
                @board.render
                puts 'Try again.'
                @board[@last_guess].hide
                @board[current_guess].hide
                sleep(1)
            end
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