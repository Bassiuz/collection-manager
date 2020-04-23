require_relative "exceptions"
module Importer
    class Parser
        class<<self
            def parse_input(input)
                validate_input(input)
                result = ""
                Card.transaction do
                    cards = []
                    card_rows = input.split("; ").in_groups(3)
                    card_rows.each do |card_row|
                        amount,name,set = card_row
                        amount = parse_amount(amount)
                        amount.times do
                          put_card_in_box(cards, name, set)
                        end
                    end
                    {cards: cards}
                end
            end
    
            def put_card_in_box(cards, name, set)
                box = find_available_box
                cards << box.cards.create!(name: name, set: set)
            end
    
            def validate_input(input)
                raise InputNotValid if input.split("; ").count() % 3 != 0
            end
    
            def find_available_box #to-do: check the size of a box before selecting it.
                box = Box.all.select{ |b| b.space_available > 0 }.first
                raise BoxNotFound if box.nil?
                box
            end
    
            def parse_amount(amount)
                raise InputNotAValidNumber if (amount.gsub("x","") =~ /[0-9]/).nil?
                amount.gsub("x","").to_i
            end
        end
    end
end