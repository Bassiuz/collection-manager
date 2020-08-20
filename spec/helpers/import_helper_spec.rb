require 'rails_helper'
require 'support/string_tool'
require './spec/factories/factories.rb'

RSpec.describe ImportHelper do
  let(:user) { FactoryBot.create(:user) }

    describe ".generate_return_message" do # '.' for class method
        describe " To generate a message containing the correct cards." do
          before do
            @cards = []
            box = Box.create!(name: "test", size: 200, user: user)
            @cards << box.cards.create!(name: "Tamiyo, Collector of Tales", set: "War of the Spark")
            @cards << box.cards.create!(name: "Tamiyo, Collector of Tales", set: "War of the Spark")
            @cards << box.cards.create!(name: "Blade of the Bloodchief", set: "Zendikar")
            @cards << box.cards.create!(name: "Blade of the Bloodchief", set: "Zendikar")
            @cards << box.cards.create!(name: "Blade of the Bloodchief", set: "Zendikar")
          end

          it "Able to parse a string to cards" do
            message = described_class.generate_return_message(@cards)
            expect(StringTool.count_in_string(message, "test")).to eql(1)
            expect(StringTool.count_in_string(message, "Blade of the Bloodchief")).to eql(3)
            expect(StringTool.count_in_string(message, "Tamiyo, Collector of Tales")).to eql(2)
          end
        end

        describe " To give a list of what cards to put in what box." do
            before do
              @cards = []
              box = Box.create!(name: "test", size: 2, user: user)
              box2 = Box.create!(name: "another box", size: 3, user: user)
              @cards << box.cards.create!(name: "Tamiyo, Collector of Tales", set: "War of the Spark")
              @cards << box2.cards.create!(name: "Tamiyo, Collector of Tales", set: "War of the Spark")
              @cards << box2.cards.create!(name: "Blade of the Bloodchief", set: "Zendikar")
              @cards << box2.cards.create!(name: "Blade of the Bloodchief", set: "Zendikar")
              @cards << box.cards.create!(name: "Blade of the Bloodchief", set: "Zendikar")
            end
  
            it "Able to parse a string to cards" do
              message = described_class.generate_return_message(@cards)
              p message
              expect(StringTool.count_in_string(message, "test")).to eql(1)
              expect(StringTool.count_in_string(message, "another box")).to eql(1)
              message_parts = message.split("another box")
              expect(StringTool.count_in_string(message_parts.first, "Blade of the Bloodchief")).to eql(1)
              expect(StringTool.count_in_string(message_parts.first, "Tamiyo, Collector of Tales")).to eql(1)
              expect(StringTool.count_in_string(message_parts.second, "Blade of the Bloodchief")).to eql(2)
              expect(StringTool.count_in_string(message_parts.second, "Tamiyo, Collector of Tales")).to eql(1)
            end
          end
    end
end
