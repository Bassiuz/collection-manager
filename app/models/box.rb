class Box < ApplicationRecord
    has_many :cards
    belongs_to :user

    def space_available
        self.size - self.cards.count
    end


    def self.types
        [StorageBox, Deckbox, Tradebinder]
    end
end
