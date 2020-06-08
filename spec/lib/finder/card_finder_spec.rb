# frozen_string_literal: true

require 'rails_helper'
require './spec/factories/factories.rb'

RSpec.describe Finder::CardFinder do
  let(:user) { FactoryBot.create(:user) }

  describe '.find_cards_for_name' do # '.' for class method
    subject do
      described_class.new(break_up_decks: true).find_cards_for_name(input)
    end
    describe 'With a valid list of cards' do
      let(:input) { '1x; Vastwood Hydra; 1x; Tamiyo, Collector of Tales' }

      before do
        Box.create(name: 'test', size: 200, user: user) do |box|
          box.cards.build(name: 'Vastwood Hydra', set: 'Magic 2014')
          box.cards.build(name: 'Tamiyo, Collector of Tales', set: 'War of the Spark')
          box.cards.build(name: 'Tamiyo, Collector of Tales', set: 'War of the Spark')
          box.cards.build(name: 'Blade of the Bloodchief', set: 'Zendikar')
        end
      end

      it 'returns the amount of cards given in the input' do
        # expect { subject }.to change { @cards.count }.by 2
        expect(subject.size).to eql(2)
      end
    end

    describe 'With a list of cards that are not enough available of' do
        let(:input) { '1x; Vastwood Hydra; 3x; Tamiyo, Collector of Tales' }
        let!(:card1) do
          Card.create!(name: 'Tamiyo, Collector of Tales', set: 'War of the Spark', box: box)
        end
        let!(:card2) do
          Card.create!(name: 'Vastwood Hydra', set: 'Magic 2014', box: box)
        end
        let!(:card3) do
          Card.create!(name: 'Tamiyo, Collector of Tales', set: 'War of the Spark', box: box)
        end
        let!(:card4) do
          Card.create!(name: 'Blade of the Bloodchief', set: 'Zendikar', box: box)
        end
        let!(:box) do
          Box.create!(name: 'test', size: 200, user: user)
        end
  
        it 'returns the amount of cards available, not the amount requested' do
          expect(subject.size).to eql(3)
        end

        it 'contains the expected cards' do
          expect(subject)
            .to contain_exactly(card1, card2, card3)
        end
      end

      describe 'With a list of cards that is divided between boxes' do
        subject do
          @cards = described_class.new(break_up_decks: true).find_cards_for_name(input)
        end
  
        let(:input) { '1x; Vastwood Hydra; 2x; Tamiyo, Collector of Tales' }
  
        before do
          @cards = []
          box = Box.create!(name: 'test', size: 200, leave_box_in_tact: true, user: user)
          @expected_results = []
          @expected_results << box.cards.create!(name: 'Vastwood Hydra', set: 'Magic 2014')
          @expected_results << box.cards.create!(name: 'Tamiyo, Collector of Tales', set: 'War of the Spark')

          box2 = Box.create!(name: 'test2', size: 200, user: user)
          box2.cards.create!(name: 'Vastwood Hydra', set: 'Magic 2014')
          @expected_results << box2.cards.create!(name: 'Tamiyo, Collector of Tales', set: 'War of the Spark')
          box2.cards.create!(name: 'Blade of the Bloodchief', set: 'Zendikar')
        end
  
        it 'returns the amount of cards available]' do
          expect { subject }.to change { @cards.count }.by 3
        end

        it 'contains the expected cards' do
          expect { subject }
            .to change { @cards }
            .to contain_exactly(@expected_results[0], @expected_results[1], @expected_results[2])
        end
      end

      describe 'With a list of cards that are in decks that cant be broken up' do
        subject do
          @cards = described_class.new.find_cards_for_name(input)
        end
  
        let(:input) { '1x; Vastwood Hydra; 2x; Tamiyo, Collector of Tales' }
  
        before do
          @cards = []
          box = Box.create!(name: 'test', size: 200, leave_box_in_tact: true, user: user)
          @expected_results = []
          box.cards.create!(name: 'Vastwood Hydra', set: 'Magic 2014')
          box.cards.create!(name: 'Tamiyo, Collector of Tales', set: 'War of the Spark')

          box2 = Box.create!(name: 'test2', size: 200, leave_box_in_tact: false, user: user)
          @expected_results << box2.cards.create!(name: 'Tamiyo, Collector of Tales', set: 'War of the Spark')
          box2.cards.create!(name: 'Blade of the Bloodchief', set: 'Zendikar')
        end
  
        it 'returns the amount of cards available in usable boxes' do
          expect { subject }.to change { @cards.count }.by 1
        end

        it 'contains the expected cards' do
          expect { subject }
            .to change { @cards }
            .to contain_exactly(@expected_results[0])
        end
      end

      describe 'With a list of card that have no matches' do
        subject do
          @cards = described_class.new(break_up_decks: false).find_cards_for_name(input)
        end
  
        let(:input) { '1x; Vastwood Hydra; 2x; Tamiyo, Collector of Tales' }
  
        before do
          @cards = []
          box = Box.create!(name: 'test', size: 200, leave_box_in_tact: true, user: user)
          box.cards.create!(name: 'Blade of the Bloodchief', set: 'Zendikar')
        end
  
        it 'to return nothing' do
          expect { subject }.to_not change{@cards}
        end
      end
  end
end
