module ImportHelper
    def parse_input(input)
        @cards = []

        inputs = input.split("; ")
        until inputs.length == 0
            set = inputs.pop
            name = inputs.pop
            amount = inputs.pop
            amount = amount.gsub("x","")
            for i in 1..amount.to_i do
                @card = Card.new()
                @card.name = name
                @card.set = set
                @card.box = find_available_box
                @card.save!
                @cards << @card
            end
        end
        @cards
    end

    def find_available_box #to-do: check the size of a box before selecting it.
        box = Box.where(id: 1).first
    end
end
