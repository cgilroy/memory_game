require_relative('card')
require('byebug')
class Board
    attr_reader :game_board
    def initialize
        @game_board = Array.new(5) {Array.new(5)}
        self.add_headers
        self.populate
    end

    def add_headers
        @game_board[0] = [' ',0,1,2,3]
        @game_board[1...@game_board.length].each_with_index do |row,index|
            row[0] = index
        end
    end

    def populate
        
        8.times do
            first_card = Card.new
            second_card = Card.new(first_card.face_value)
            [first_card,second_card].each do |card|
                index = [1,1]
                until @game_board[index[0]][index[1]] == nil do
                    index = [rand(1..4),rand(1..4)]
                end
                @game_board[index[0]][index[1]] = card if @game_board[index[0]][index[1]] == nil
            end
        end
        # debugger
    end

    def [](pos)
        pos_array = pos.split(',')
        output = @game_board[pos_array[0].to_i+1][pos_array[1].to_i+1]
        output
    end

    def render
        @game_board.each do |row|
            row.each do |card|
                if card.is_a?(Card)
                    if card.face_up 
                        print card.to_s + ' '
                    else
                        print '  '
                    end
                else
                    print card.to_s + ' '
                end
            end
            puts
        end
    end

    # def test_render
    #     @game_board.each do |row|
    #         row.each do |card|
    #             if card.is_a?(Card)
    #                 print card.to_s + ' '
    #             else
    #                 print card.to_s + ' '
    #             end
    #         end
    #         puts
    #     end
    # end
end