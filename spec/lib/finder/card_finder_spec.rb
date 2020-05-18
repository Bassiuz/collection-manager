# frozen_string_literal: true

require 'rails_helper'
require './app/lib/importer/parser'

RSpec.describe Finder::CardFinder do
  describe '.find_cards_for_name' do # '.' for class method
    describe 'With a valid list of cards' do
      subject do
        @cards = described_class.new(break_up_decks: true).find_cards_for_name(input)
      end

      let(:input) { '1x; Vastwood Hydra; 1x; Tamiyo, Collector of Tales;' }

      before do
        @cards = []
        box = Box.create!(name: 'test', size: 200)
        box.cards.create!(name: 'Vastwood Hydra', set: 'Magic 2014')
        box.cards.create!(name: 'Tamiyo, Collector of Tales', set: 'War of the Spark')
        box.cards.create!(name: 'Tamiyo, Collector of Tales', set: 'War of the Spark')
        box.cards.create!(name: 'Blade of the Bloodchief', set: 'Zendikar')

        # InputParser.parse_input(:input)
      end

      it 'returns the amount of cards given in the input' do
        expect { subject }.to change { @cards.count }.by 2
      end
    end

    describe 'With a list of cards that are not enough available of' do
        subject do
          @cards = described_class.new(break_up_decks: true).find_cards_for_name(input)
        end
  
        let(:input) { '1x; Vastwood Hydra; 3x; Tamiyo, Collector of Tales;' }
  
        before do
          @cards = []
          box = Box.create!(name: 'test', size: 200)
          box.cards.create!(name: 'Vastwood Hydra', set: 'Magic 2014')
          box.cards.create!(name: 'Tamiyo, Collector of Tales', set: 'War of the Spark')
          box.cards.create!(name: 'Tamiyo, Collector of Tales', set: 'War of the Spark')
          box.cards.create!(name: 'Blade of the Bloodchief', set: 'Zendikar')
  
          # InputParser.parse_input(:input)
        end
  
        it 'returns the amount of cards available, not the amount requested' do
          expect { subject }.to change { @cards.count }.by 2
        end
      end
  end
end
