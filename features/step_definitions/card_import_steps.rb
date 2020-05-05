Given("I have the following list of cards: {string}") do |input_list|
  @cardlist = input_list
end

Given("I have a box with name {string} and size {int}") do |box_name, box_size|
    Box.create!(name: box_name, size: box_size)
end

When("I navigate to the import page") do
    visit "/import"
    expect(current_path).to eql(import_index_path)
end

When("I submit my list in the import page") do
    fill_in('import_input', with: @cardlist)
    click_button("Submit")
end

Then("the following cards should be added:") do |table|
    # table is a Cucumber::MultilineArgument::DataTable
    table.hashes.each do |card_row|
        quantity = card_row.delete("quantity").to_i
        assert Card.where(card_row).count == quantity
    end
end

Then("I should see where I need to store my cards") do #to-do: more specific testing of view on the page.
    assert page.has_content?("Vastwood Hydra")
end