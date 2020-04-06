# Collection Manager

The collection manager is a tool to organize your card collection in such a way that there is the least amount of upkeep. This is not a way to sort your cards in a logical way; everything is built with ease of storing new cards in mind. 


## Wants for the application

There are a couple of goals I want to achieve with this application:
- Insert a list of cards and get a report of where i can find them
- From a inserted list of cards, get the list of cards i do not have yet in a format that webshops (eg. Magiccardmarket) accept
- Difference between a 'deck' and an 'collection box' (one keeps track of location in the box, other gets shuffled a lot)

Nice things to have would be;
- Ready for deployment with docker (and K8s)
- Backupable in a simple way (and automated with a cronjob?)
- A seperated 'publicly available' part where people can look at my collection.
- A beautify UI
- Autofill cardnames



## To-do list:
- refactor the basics 
- create import/export with EZImport (https://github.com/jkorz/ezimport)
- create card retrieval view
