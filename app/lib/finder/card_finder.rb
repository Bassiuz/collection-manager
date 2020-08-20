# frozen_string_literal: true

require_relative 'finder_error'
module Finder
  # CardFinder - Find cards in available boxes by card names
  class CardFinder
    attr_accessor :break_up_decks

    def initialize(break_up_decks: false)
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

      if @break_up_decks
        @available_boxes = Box.all
      else
        @available_boxes = Box.where.not(leave_box_in_tact: true)
      end

      amount.times do
        matching_cards = Card.where(name: name, box: @available_boxes)
        return if matching_cards.empty?
        
        if @cards.empty?
          @cards << matching_cards.first
        else
          find_card_not_already_found(matching_cards)
        end
      end
    end

    def find_card_not_already_found(matching_cards)
      return if matching_cards.empty?

      found_card = matching_cards.where.not(id: @cards.map(&:id)).first
      @cards << found_card unless found_card.nil?
    end
  end
end
