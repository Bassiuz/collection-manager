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

        def parse_cardnames_list
            Card.transaction do
                cards = []
                input.each do |input|
                    put_card_in_box(cards, input, "Set Unknown")
                end
                cards
            end
        end

        def parse_raw_input
            validate_input
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
            box = Box.where(box_type: "Storage Box").select{ |b| b.space_available > 0 }.first
            raise BoxNotFound if box.nil?
            box
        end

        def parse_amount(amount)
            raise InputNotAValidNumber if (amount.gsub("x","") =~ /[0-9]/).nil?
            amount.gsub("x","").to_i
        end

        def self.parse_raw_input(input)
            new(input).parse_raw_input
        end

        def self.parse_cardnames_list(input)
            new(input).parse_cardnames_list
        end
    end
end