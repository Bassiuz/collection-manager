require_relative "box_error"
module Importer
    class Parser 
        def self.parse_input(input)
            result = ""
            Card.transaction do
                cards = []
                raise InputNotValid if input.split("; ").count() % 3 != 0
                card_rows = input.split("; ").in_groups(3)
                card_rows.each do |card_row|
                    amount,name,set = card_row
                    amount = parse_amount(amount)
                    amount.times do
                        box = find_available_box
                        cards << box.cards.create!(name: name, set: set)
                    end
                end
                {cards: cards}
            end
        end

        def self.find_available_box #to-do: check the size of a box before selecting it.
            box = Box.all.select{ |b| b.space_available > 0 }.first
            raise BoxNotFound if box.nil?
            box
        end

        def self.parse_amount(amount)
            raise InputNotAValidNumber if (amount.gsub("x","") =~ /[0-9]/).nil?
            amount.gsub("x","").to_i
        end
    end
end