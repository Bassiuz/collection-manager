Given("I have the following cards in a box named {string}:") do |box_name, card_table|
    Box.create(name: box_name) do |box|
        box.cards.build(card_table.hashes)
    end
end

When("I navigate to the {string} page") do |page_name|
    pending # Write code here that turns the phrase above into concrete actions
end

Given("I want to find a card named {string}") do |card_name|
  pending # Write code here that turns the phrase above into concrete actions
end
  
Then("I should see that it is in a box named {string}") do |box_name|
  pending # Write code here that turns the phrase above into concrete actions
end