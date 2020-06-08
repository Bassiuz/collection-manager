require 'rails_helper'
require 'factory_bot'
require './spec/factories/factories.rb'

 RSpec.describe Importer::Parser do
  let(:user) { FactoryBot.create(:user) }
  describe ".parse_cardnames_list" do # '.' for class method
    describe "With a valid list of cards and a available box" do
      subject do
        described_class.parse_cardnames_list(input)
      end

      let(:input) { ["Vastwood Hydra", "Tamiyo, Collector of Tales", "Blade of the Bloodchief", "Tamiyo, Collector of Tales"] }
      
      before do
        Box.create!(name: "test", size: 200, user: user)
      end
    
      it "imports the correct total amount of cards" do
        expect {subject}.to change{Card.count}.by 4 
      end
           
      it "imports cards with the same name multiple times" do
        expect {subject}.to change{Card.where(name:"Tamiyo, Collector of Tales").count}.by 2 
      end

      it "returns only the card in the input list" do
        described_class.parse_cardnames_list(input)
        @added_cards = subject
        pp @added_cards
        expect(Card.where(name:"Tamiyo, Collector of Tales").count()).to eql(4)
        expect(Card.where(name:"Tamiyo, Collector of Tales", id: @added_cards.pluck(:id)).count()).to eql(2)
      end
    end
  end
    describe ".parse_raw_input" do # '.' for class method
      describe "With a valid list of cards and a available box" do
        subject do
          described_class.parse_raw_input(input)
        end

        let(:input) { "1x; Vastwood Hydra; Magic 2014; 2x; Tamiyo, Collector of Tales; War of the Spark; 1x; Blade of the Bloodchief; Zendikar" }
        
        before do
          Box.create!(name: "test", size: 200, user: user)
        end
      
        it "imports the correct total amount of cards" do
          expect {subject}.to change{Card.count}.by 4 
        end
             
        it "imports cards with the same name multiple times" do
          expect {subject}.to change{Card.where(name:"Tamiyo, Collector of Tales").count}.by 2 
        end

        it "returns only the card in the input list" do
          described_class.parse_raw_input(input)
          @added_cards = subject
          pp @added_cards
          expect(Card.where(name:"Tamiyo, Collector of Tales").count()).to eql(4)
          expect(Card.where(name:"Tamiyo, Collector of Tales", id: @added_cards.pluck(:id)).count()).to eql(2)
        end
      end
    
    
      describe "with no storage box available" do
        let(:input) { "1x; Vastwood Hydra; Magic 2014; 2x; Tamiyo, Collector of Tales; War of the Spark; 1x; Blade of the Bloodchief; Zendikar" }
        before do
          Box.create!(name: "Tradebinder", size: 300, box_type:"Tradebinder", user: user)
          Box.create!(name: "Deckbox", size: 1, box_type:"Deckbox", user: user)
        end
      
        def parse(input)
          @added_cards = described_class.parse_raw_input(input)
        end
             
        it "to raise an error because there is no box available" do
          expect {parse(input)}.to raise_error(Importer::BoxNotFound)
        end
      end

      describe "with no box available" do
        let(:input) { "1x; Vastwood Hydra; Magic 2014; 2x; Tamiyo, Collector of Tales; War of the Spark; 1x; Blade of the Bloodchief; Zendikar" }
        before do
        end
      
        def parse(input)
          @added_cards = described_class.parse_raw_input(input)
        end
             
        it "to raise an error because there is no box available" do
          expect {parse(input)}.to raise_error(Importer::BoxNotFound)
        end
      end
      
      describe "with not enough space in boxes availble" do
        let(:input) { "2x; Tamiyo, Collector of Tales; War of the Spark; 2x; Tamiyo, Collector of Tales; War of the Spark; 1x; Blade of the Bloodchief; Zendikar" }
        before do
          Box.create!(name: "small box", size: 1, user: user)
        end
      
        def parse(input)
          @added_cards = described_class.parse_raw_input(input)
        end
             
        it "to not add any card to the boxes, even the ones that do fit" do
          begin 
            parse(input)
          rescue
          end
          expect(Card.where(name:"Tamiyo, Collector of Tales").count()).to eql(0)
        end

        it "to raise an error because there is not enough room available" do
          expect {parse(input)}.to raise_error(Importer::BoxNotFound)
        end
      end
    
      describe "With a valid list of cards and enough room divided between boxes" do
        let(:input) { "2x; Tamiyo, Collector of Tales; War of the Spark; 2x; Tamiyo, Collector of Tales; War of the Spark; 1x; Blade of the Bloodchief; Zendikar" }
        before do
          Box.create!(name: "small box", size: 2, user: user)
          Box.create!(name: "another  box", size: 3, user: user)
          parse(input)
        end
      
        def parse(input)
          @added_cards = described_class.parse_raw_input(input)
        end
             
        it "to import the cards and put them into boxes" do
          expect(Card.where(name:"Tamiyo, Collector of Tales").count()).to eql(4)
        end
      end
    
      describe "without a valid list of cards" do
        let(:input) { "asdfasdfasdfasdf" }
        before do        
          Box.create!(name: "test", size: 200, user: user)
        end
      
        def parse(input)
          @added_cards = described_class.parse_raw_input(input)
        end
        
        it "To raise an error when trying to import the cards" do
          expect {parse(input)}.to raise_error(Importer::InputNotValid)
        end 
      end
    
      describe "without a valid integer in the amount box of a list" do
        let(:input) { "een keer; Vastwood Hydra; Magic 2014; 2x; Tamiyo, Collector of Tales; War of the Spark; 1x; Blade of the Bloodchief; Zendikar" }
        before do        
          Box.create!(name: "test", size: 200, user: user)
        end
      
        def parse(input)
          @added_cards = described_class.parse_raw_input(input)
        end

        it "To raise an error when trying to import the cards" do
          expect {parse(input)}.to raise_error(Importer::InputNotAValidNumber)
        end  
      end
    end
  end
