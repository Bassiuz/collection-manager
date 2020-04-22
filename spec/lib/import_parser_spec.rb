require 'rails_helper'

RSpec.describe ImportParser do
  describe ".parse_input" do # '.' for class method
    describe " To save to database" do
      let(:input) { "1x; Vastwood Hydra; Magic 2014; 2x; Tamiyo, Collector of Tales; War of the Spark; 1x; Blade of the Bloodchief; Zendikar" }
      before do
        Box.create!(name: "test", size: 200)
      end

      def parse(input)
        described_class.parse_input(input)
      end
           
      it "Able to parse a string to cards" do
        parse(input)
        expect(Card.count()).to eql(4)
      end
           
      it "Able to add the same card multiple times" do
        parse(input)
        expect(Card.where(name:"Tamiyo, Collector of Tales").count()).to eql(2)
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
        parse(input)
      end

      def parse(input)
        @added_cards = described_class.parse_input(input)
      end
           
      it "Able to parse a string to cards" do
        expect(@added_cards[:error_code]).to eql(Exceptions::BoxNotFound.new.error_code)
        expect(@added_cards[:message]).to eql(Exceptions::BoxNotFound.new.message)
      end
    end

    describe " To give an error when there is no valid input given" do
      let(:input) { "asdfasdfasdfasdf" }
      before do        
        Box.create!(name: "test", size: 200)
        parse(input)
      end

      def parse(input)
        @added_cards = described_class.parse_input(input)
      end
           
      it "Able to parse a string to cards" do
        expect(@added_cards[:error_code]).to eql(Exceptions::InputNotValid.new.error_code)
        expect(@added_cards[:message]).to eql(Exceptions::InputNotValid.new.message)
      end
    end

    describe " To give an error when there is no valid input given" do
      let(:input) { "een keer; Vastwood Hydra; Magic 2014; 2x; Tamiyo, Collector of Tales; War of the Spark; 1x; Blade of the Bloodchief; Zendikar" }
      before do        
        Box.create!(name: "test", size: 200)
        parse(input)
      end

      def parse(input)
        @added_cards = described_class.parse_input(input)
      end
           
      it "Able to parse a string to cards" do
        expect(@added_cards[:error_code]).to eql(Exceptions::InputNotAValidNumber.new.error_code)
        expect(@added_cards[:message]).to eql(Exceptions::InputNotAValidNumber.new.message)
      end
    end
  end
end
