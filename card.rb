class Card
    attr_reader :face_value, :face_up
    def initialize(value)
        @face_value = value
        @face_up = false
    end
    
    def hide
        @face_up = false
    end

    def reveal
        @face_up = true
    end

    def ==(compare_card)
        return false if compare_card == nil
        @face_value == compare_card.face_value
    end

    def to_s
        @face_value.to_s
    end

    def display
        return @face_value if @face_up
    end
end