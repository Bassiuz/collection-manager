module ImportHelper
    def generate_return_message(cards)
        if cards.length > 0
            @message = ""
            for card in cards
                if @message.length > 0
                    @message = @message+ ", "
                end
                @message = @message + card.name
            end
            @message = @message + " added!"
        else
            @message = "Cards could not be imported."
        end
    end
end
