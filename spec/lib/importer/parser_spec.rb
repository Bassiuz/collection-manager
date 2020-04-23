require 'rails_helper'

 RSpec.describe Importer::Parser do
    describe ".parse_input" do # '.' for class method
      describe "With a valid list of cards" do
        subject do
          described_class.parse_input(input)
        end

        let(:input) { "1x; Vastwood Hydra; Magic 2014; 2x; Tamiyo, Collector of Tales; War of the Spark; 1x; Blade of the Bloodchief; Zendikar" }
        
        before do
          Box.create!(name: "test", size: 200)
        end
      
        it "imports the correct total amount of cards" do
          expect {subject}.to change{Card.count}.by 4 
        end
             
        it "imports cards with the same name multiple times" do
          expect {subject}.to change{Card.where(name:"Tamiyo, Collector of Tales").count}.by 2 
        end
      end
    
      describe " To return the added cards" do
        let(:input) { "1x; Vastwood Hydra; Magic 2014; 2x; Tamiyo, Collector of Tales; War of the Spark; 1x; Blade of the Bloodchief; Zendikar" }
        before do
          Box.create!(name: "test", size: 200)
          parse(input)
        end
      
        def parse(input)
          @added_cards = described_class.parse_input(input)
        end
             
        it "Able to parse a string to cards" do
          expect(Card.count()).to eql(4)
        end
             
        it "Able to add the same card multiple times" do
          parse(input)
          expect(Card.where(name:"Tamiyo, Collector of Tales").count()).to eql(4)
          expect(Card.where(name:"Tamiyo, Collector of Tales", id: @added_cards.pluck(:id)).count()).to eql(2)
        end
      end
    
      describe " To give an error when there is no box available" do
        let(:input) { "1x; Vastwood Hydra; Magic 2014; 2x; Tamiyo, Collector of Tales; War of the Spark; 1x; Blade of the Bloodchief; Zendikar" }
        before do
        end
      
        def parse(input)
          @added_cards = described_class.parse_input(input)
        end
             
        it "Able to parse a string to cards" do
          expect {parse(input)}.to raise_error(Importer::BoxNotFound)
        end
      end
      
      describe " To give an error when there is not a big enough box available" do
        let(:input) { "2x; Tamiyo, Collector of Tales; War of the Spark; 2x; Tamiyo, Collector of Tales; War of the Spark; 1x; Blade of the Bloodchief; Zendikar" }
        before do
          Box.create!(name: "small box", size: 1)
        end
      
        def parse(input)
          @added_cards = described_class.parse_input(input)
        end
             
        it "Able to parse a string to cards" do
          begin 
            parse(input)
          rescue
          end
          expect(Card.where(name:"Tamiyo, Collector of Tales").count()).to eql(0)
        end

        it "Able to parse a string to cards2" do
          expect {parse(input)}.to raise_error(Importer::BoxNotFound)
        end
      end
    
      describe " To divide the card over multiple boxes if needed" do
        let(:input) { "2x; Tamiyo, Collector of Tales; War of the Spark; 2x; Tamiyo, Collector of Tales; War of the Spark; 1x; Blade of the Bloodchief; Zendikar" }
        before do
          Box.create!(name: "small box", size: 2)
          Box.create!(name: "another  box", size: 3)
          parse(input)
        end
      
        def parse(input)
          @added_cards = described_class.parse_input(input)
        end
             
        it "Able to parse a string to cards" do
          expect(Card.where(name:"Tamiyo, Collector of Tales").count()).to eql(4)
        end
      end
    
      describe " To give an error when there is no valid input given" do
        let(:input) { "asdfasdfasdfasdf" }
        before do        
          Box.create!(name: "test", size: 200)
        end
      
        def parse(input)
          @added_cards = described_class.parse_input(input)
        end
        
        it "Able to parse a string to cards2" do
          expect {parse(input)}.to raise_error(Importer::InputNotValid)
        end 
      end
    
      describe " To give an error when there is no valid input given" do
        let(:input) { "een keer; Vastwood Hydra; Magic 2014; 2x; Tamiyo, Collector of Tales; War of the Spark; 1x; Blade of the Bloodchief; Zendikar" }
        before do        
          Box.create!(name: "test", size: 200)
        end
      
        def parse(input)
          @added_cards = described_class.parse_input(input)
        end

        it "Able to parse a string to cards2" do
          expect {parse(input)}.to raise_error(Importer::InputNotAValidNumber)
        end  
      end
    end
  end
