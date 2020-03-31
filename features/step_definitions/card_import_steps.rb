Given("I have a list of cards") do
  @cardlist = "1x; Vastwood Hydra; Magic 2014; 1x; Tamiyo, Collector of Tales; War of the Spark; 1x; Blade of the Bloodchief; Zendikar"
end

Given("I have a box with enough space") do
    Box.new(name: "testbox", size: 200).save!
end

When("I navigate to the import page") do
    visit "/import"
end

When("I submit my list in the import page") do
    fill_in('import_input', :with => @cardlist)
    click_button("Submit")
end

Then("my cards should be added to the application") do
    assert Card.where(name:"Vastwood Hydra").exists?
    assert Card.where(name:"Vastwood Hydra").last.set == "Magic 2014"
    assert Card.where(name:"Tamiyo, Collector of Tales").exists?
    assert Card.where(name:"Blade of the Bloodchief").exists?
end

Then("I should see where I need to store my cards") do #to-do: more specific testing of view on the page.
    assert page.has_content?("Vastwood Hydra")
end