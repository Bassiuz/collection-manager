Feature: Card Import
    In order to store cards in a good way
    As a card collector
    I want to import cards and see where I need to store them
        Scenario: Import cards
            Given I have a list of cards
            And I have a box with enough space
            When I navigate to the import page
            And I submit my list in the import page
            Then my cards should be added to the application
            And I should see where I need to store my cards