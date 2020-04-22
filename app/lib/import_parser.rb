class ImportParser 
    def self.parse_input(input)
        begin
            cards = []
            raise Exceptions::InputNotValid.new if input.split("; ").count() % 3 != 0
            card_rows = input.split("; ").in_groups(3)
            p card_rows
            box = find_available_box
            card_rows.each do |card_row|
                #["1x", "Vastwood Hydra", "Magic 2014"]
                amount,name,set = card_row
                amount = parse_amount(amount)
                amount.times do
                    cards << box.cards.create!(name: name, set: set)
                end
            end
            cards
        rescue Exceptions::BoxError => exc
            p "Error while looking for box: #{exc.message}"
            {error_code:exc.error_code, message: exc.message}
        rescue Exceptions::InputError => exc
            p "Error while parsing input: #{exc.message}"
            {error_code:exc.error_code, message: exc.message}
        end
    end

    def self.find_available_box #to-do: check the size of a box before selecting it.
        box = Box.where(id: 1).first
        raise Exceptions::BoxNotFound.new if box.nil?
        box
    end

    def self.parse_amount(amount)
        raise Exceptions::InputNotAValidNumber.new if (amount.gsub("x","") =~ /[0-9]/).nil?
        amount.gsub("x","").to_i
    end
end
  