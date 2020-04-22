class Box < ApplicationRecord
    has_many :cards
    
    def space_available
        self.size - self.cards.count
    end
end
