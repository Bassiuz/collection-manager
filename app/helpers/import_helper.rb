module ImportHelper
    def self.generate_return_message(cards)
        if cards.length > 0
            cards = cards.sort {|a, b| a[:box_id] <=> b[:box_id]}
            @message = ""
            current_box = ""
            for card in cards
                if (current_box != card.box)
                    current_box = card.box
                    @message = @message + "Add these cards to box #{card.box.name} : "
                end
                @message = @message + card.name + " "
            end
            @message
        else
            @message = "Cards could not be imported."
        end
    end
end
