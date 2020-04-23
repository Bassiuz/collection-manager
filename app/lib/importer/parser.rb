require_relative "importer_error"
module Importer
    class Parser
        attr_accessor :input, :amount

        def initialize(input)
            @input = input                 
        end

        def amount=(value)
            @amount = parse_amount(value)
        end

        def parse_input
            validate_input
            result = ""
                Card.transaction do
                    cards = []
                    card_rows = input.split("; ").in_groups(3)
                    card_rows.each do |card_row|
                        self.amount,name,set = card_row
                        amount.times do
                          put_card_in_box(cards, name, set)
                        end
                    end
                cards
            end
        end

        def validate_input
            raise InputNotValid if input.split("; ").count() % 3 != 0
        end

        def put_card_in_box(cards, name, set)
            box = find_available_box
            cards << box.cards.create!(name: name, set: set)
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

        def self.parse_input(input)
            new(input).parse_input
        end
    end
end