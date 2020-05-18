# frozen_string_literal: true

require_relative 'finder_error'
module Finder
  # CardFinder - Find cards in available boxes by card names
  class CardFinder
    attr_accessor :break_up_decks

    def initialize(break_up_decks)
      @break_up_decks = break_up_decks
    end

    def find_cards_for_name(card_names)
      @cards = []
      card_rows = card_names.split('; ').in_groups(2)
      card_rows.each do |card_row|
        find_card_for_name(card_row)
      end
      @cards
    end

    private

    def find_card_for_name(card_row)
      amount, name = card_row
      amount = amount.gsub('x', '').to_i
      amount.times do
        if @cards.empty?
          @cards << Card.where(name: name).first
        else
          matching_cards = Card.where(name: name)
          byebug
          unless matching_cards.empty?
            @cards << matching_cards.where(id: @cards.map(&:id)).first
          end
        end
      end
    end
  end
end
