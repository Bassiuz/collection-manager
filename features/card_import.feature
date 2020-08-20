@wip
Feature: Card Import
    In order to store cards in a good way
    As a card collector
    I want to import cards and see where I need to store them
    Scenario: Import cards
        Given I have the following list of cards: "1x; Vastwood Hydra; Magic 2014; 2x; Tamiyo, Collector of Tales; War of the Spark; 1x; Blade of the Bloodchief; Zendikar"
        And I have a box with name "test" and size 200
        When I navigate to the import page
        And I submit my list in the import page
        Then the following cards should be added:
            | quantity | name                       | set              |
            | 1        | Vastwood Hydra             | Magic 2014       |
            | 2        | Tamiyo, Collector of Tales | War of the Spark |
            | 1        | Blade of the Bloodchief    | Zendikar         |
        And I should see where I need to store my cards