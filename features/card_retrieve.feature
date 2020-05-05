@todo
Feature: Card retrieve
    In order to find the cards I want
    As a card collector
    I want know in what boxes my cards are
    Scenario: No available box
        Given I have the following cards in a box named "Test":
            | name                       | set              |
            | Vastwood Hydra             | Magic 2014       |
            | Tamiyo, Collector of Tales | War of the Spark |
            | Blade of the Bloodchief    | Zendikar         |
            | Tamiyo, Collector of Tales | War of the Spark |
        When I navigate to the "search" page
        And I want to find a card named "Blade of the Bloodchief"
        Then I should see that it is in a box named "Test"