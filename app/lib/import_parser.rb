class ImportParser 
    def self.parse_input(input)
        result = ""
        Card.transaction do
            begin
                cards = []
                raise Exceptions::InputNotValid.new if input.split("; ").count() % 3 != 0
                card_rows = input.split("; ").in_groups(3)
                card_rows.each do |card_row|
                    amount,name,set = card_row
                    amount = parse_amount(amount)
                    amount.times do
                        box = find_available_box
                        cards << box.cards.create!(name: name, set: set)
                    end
                end
                result = {cards: cards}
            rescue Exceptions::BoxError => exc
                p "Error while looking for box: #{exc.message}"
                result = {error_code:exc.error_code, message: exc.message}
                raise ActiveRecord::Rollback, "Rolling back saving import"
            rescue Exceptions::InputError => exc
                p "Error while parsing input: #{exc.message}"
                result = {error_code:exc.error_code, message: exc.message}
                raise ActiveRecord::Rollback, "Rolling back saving import"
            end
        end
        result
    end

    def self.find_available_box #to-do: check the size of a box before selecting it.
        box = Box.all.select{ |b| b.space_available > 0 }.first
        raise Exceptions::BoxNotFound.new if box.nil?
        box
    end

    def self.parse_amount(amount)
        raise Exceptions::InputNotAValidNumber.new if (amount.gsub("x","") =~ /[0-9]/).nil?
        amount.gsub("x","").to_i
    end
end
  