# frozen_string_literal: true

require 'rails_helper'
require './app/lib/importer/parser'

RSpec.describe Finder::CardFinder do
  describe '.find_cards_for_name' do # '.' for class method
    describe 'With a valid list of cards' do
      subject do
        @cards = described_class.new(break_up_decks: true).find_cards_for_name(input)
      end

      let(:input) { '1x; Vastwood Hydra; 1x; Tamiyo, Collector of Tales' }

      before do
        @cards = []
        box = Box.create!(name: 'test', size: 200)
        box.cards.create!(name: 'Vastwood Hydra', set: 'Magic 2014')
        box.cards.create!(name: 'Tamiyo, Collector of Tales', set: 'War of the Spark')
        box.cards.create!(name: 'Tamiyo, Collector of Tales', set: 'War of the Spark')
        box.cards.create!(name: 'Blade of the Bloodchief', set: 'Zendikar')

        # InputParser.parse_input(:input) Patrick: how do i load this class? (if I wanted to?)
      end

      it 'returns the amount of cards given in the input' do
        expect { subject }.to change { @cards.count }.by 2
      end
    end

    describe 'With a list of cards that are not enough available of' do
        subject do
          @cards = described_class.new(break_up_decks: true).find_cards_for_name(input)
        end
  
        let(:input) { '1x; Vastwood Hydra; 3x; Tamiyo, Collector of Tales' }
  
        before do
          @cards = []
          box = Box.create!(name: 'test', size: 200)
          @expected_results = []
          @expected_results << box.cards.create!(name: 'Vastwood Hydra', set: 'Magic 2014')
          @expected_results << box.cards.create!(name: 'Tamiyo, Collector of Tales', set: 'War of the Spark')
          @expected_results << box.cards.create!(name: 'Tamiyo, Collector of Tales', set: 'War of the Spark')
          pp @expected_results
          box.cards.create!(name: 'Blade of the Bloodchief', set: 'Zendikar')
  
          # InputParser.parse_input(:input)
        end
  
        it 'returns the amount of cards available, not the amount requested' do
          expect { subject }.to change { @cards.count }.by 3
        end

        it 'contains the expected cards' do
          expect { subject }
            .to change { @cards }
            .to contain_exactly(@expected_results[0], @expected_results[1], @expected_results[2])
            #.to contain_exactly(@expected_results) Patrick: doesn't work? 
        end
      end

      describe 'With a list of cards that is divided between boxes' do
        subject do
          @cards = described_class.new(break_up_decks: true).find_cards_for_name(input)
        end
  
        let(:input) { '1x; Vastwood Hydra; 2x; Tamiyo, Collector of Tales' }
  
        before do
          @cards = []
          box = Box.create!(name: 'test', size: 200, leave_box_in_tact: true)
          @expected_results = []
          @expected_results << box.cards.create!(name: 'Vastwood Hydra', set: 'Magic 2014')
          @expected_results << box.cards.create!(name: 'Tamiyo, Collector of Tales', set: 'War of the Spark')

          box2 = Box.create!(name: 'test2', size: 200)
          box2.cards.create!(name: 'Vastwood Hydra', set: 'Magic 2014')
          @expected_results << box2.cards.create!(name: 'Tamiyo, Collector of Tales', set: 'War of the Spark')
          box2.cards.create!(name: 'Blade of the Bloodchief', set: 'Zendikar')
  
          # InputParser.parse_input(:input)
        end
  
        it 'returns the amount of cards available]' do
          expect { subject }.to change { @cards.count }.by 3
        end

        it 'contains the expected cards' do
          expect { subject }
            .to change { @cards }
            .to contain_exactly(@expected_results[0], @expected_results[1], @expected_results[2])
            #.to contain_exactly(@expected_results) Patrick: doesn't work? 
        end
      end

      describe 'With a list of cards that are in decks that cant be broken up' do
        subject do
          @cards = described_class.new(break_up_decks: false).find_cards_for_name(input)
        end
  
        let(:input) { '1x; Vastwood Hydra; 2x; Tamiyo, Collector of Tales' }
  
        before do
          @cards = []
          box = Box.create!(name: 'test', size: 200, leave_box_in_tact: true)
          @expected_results = []
          box.cards.create!(name: 'Vastwood Hydra', set: 'Magic 2014')
          box.cards.create!(name: 'Tamiyo, Collector of Tales', set: 'War of the Spark')

          box2 = Box.create!(name: 'test2', size: 200, leave_box_in_tact: false)
          @expected_results << box2.cards.create!(name: 'Tamiyo, Collector of Tales', set: 'War of the Spark')
          box2.cards.create!(name: 'Blade of the Bloodchief', set: 'Zendikar')
  
          # InputParser.parse_input(:input)
        end
  
        it 'returns the amount of cards available in usable boxes' do
          expect { subject }.to change { @cards.count }.by 1
        end

        it 'contains the expected cards' do
          expect { subject }
            .to change { @cards }
            .to contain_exactly(@expected_results[0])
            #.to contain_exactly(@expected_results) Patrick: doesn't work? 
        end
      end

      describe 'With a list of card that have no matches' do
        subject do
          @cards = described_class.new(break_up_decks: false).find_cards_for_name(input)
        end
  
        let(:input) { '1x; Vastwood Hydra; 2x; Tamiyo, Collector of Tales' }
  
        before do
          @cards = []
          box = Box.create!(name: 'test', size: 200, leave_box_in_tact: true)
          box.cards.create!(name: 'Blade of the Bloodchief', set: 'Zendikar')
        end
  
        it 'to return nothing' do
          expect { subject }.to_not change{@cards}
        end
      end
  end
end
