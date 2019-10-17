

class ComputerPlayer
    attr_accessor :matched_cards
    def initialize
        @known_cards = Hash.new {[]}
        @matched_cards = []
        @unmade_matches
    end

    def get_guess(last_guess)
        puts "Please enter your guess e.g. '1,3'"
        if last_guess == ''
            guess = make_first_guess
        else
            guess = make_second_guess(last_guess)
        end
        guess
    end

    def make_first_guess
        self.update_unmade_matches
        if @unmade_matches.length !=0
            return @unmade_matches[@unmade_matches.keys[0]][0]
        else
            return self.choose_random_unknown_pos
        end
        
    end

    def make_second_guess(last_guess)
        self.update_unmade_matches
        if @unmade_matches.length !=0
            last_guess_arr = @unmade_matches.select { |k,v| v.include?(last_guess) }
            if last_guess_arr != {}
                current_guess = last_guess_arr.values[0].select { |el| el != last_guess }
                return current_guess[0]
            else
                return @unmade_matches[last_guess][1]
            end 
        else
            return self.choose_random_unknown_pos
        end
    end

    def combine_all_pos(hash)
        all_pos = []
        hash.each { |k,v| all_pos << v }
        all_pos.flatten
    end

    def choose_random_unknown_pos
        row, col = rand(0..3),rand(0..3)
        until !self.combine_all_pos(@known_cards).include?(row.to_s+","+col.to_s)
            row, col = rand(0..3),rand(0..3)
        end
        return row.to_s+","+col.to_s
    end

    def update_unmade_matches
        @unmade_matches = @known_cards.select { |k,v| v.length == 2 && !matched_cards.include?(v[0]) && !matched_cards.include?(v[1]) }
    end

    def receive_revealed_card(pos,val)
        arr = @known_cards[val]
        arr << pos unless arr.include?(pos)
        @known_cards[val] = arr
    end

    def receive_match(pos1,pos2)
        @matched_cards << pos1 unless @matched_cards.include?(pos1)
        @matched_cards << pos2 unless @matched_cards.include?(pos2)
    end

end