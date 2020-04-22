require 'rails_helper'
require 'test/string_tool'

RSpec.describe ImportHelper do
    describe ".generate_return_message" do # '.' for class method
        describe " To generate a valid return message to view on the page." do
          before do
            @cards = []
            box = Box.create!(name: "test", size: 200)
            @cards << box.cards.create!(name: "Tamiyo, Collector of Tales", set: "War of the Spark")
            @cards << box.cards.create!(name: "Tamiyo, Collector of Tales", set: "War of the Spark")
            @cards << box.cards.create!(name: "Blade of the Bloodchief", set: "Zendikar")
            @cards << box.cards.create!(name: "Blade of the Bloodchief", set: "Zendikar")
            @cards << box.cards.create!(name: "Blade of the Bloodchief", set: "Zendikar")
          end

          it "Able to parse a string to cards" do
            message = described_class.generate_return_message(@cards)
            expect(StringTool.count_in_string(message, "Blade of the Bloodchief")).to eql(3)
            expect(StringTool.count_in_string(message, "Tamiyo, Collector of Tales")).to eql(2)
          end
        end
    end
end
