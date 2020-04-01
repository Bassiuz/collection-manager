class ImportParser 
    def self.parse_input(input)
        cards = []
        card_rows = input.split("; ").in_groups(3)
        box = find_available_box
        card_rows.each do |card_row|
            #["1x", "Vastwood Hydra", "Magic 2014"]
            amount,name,set = card_row
            amount = amount.gsub("x","").to_i
            amount.times do
                cards << box.cards.create!(name: name, set: set)
            end
        end
        cards
    end

    def self.find_available_box #to-do: check the size of a box before selecting it.
        Box.where(id: 1).first
    end
end
  