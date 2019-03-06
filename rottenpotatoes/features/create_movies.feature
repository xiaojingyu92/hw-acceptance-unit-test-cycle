Feature: create movie
 
  As a user
  So that I can add movie
  I want to manage the movie list
 
Background: movies are in the database
 
  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |

Scenario: add movie to database
  When I am on the RottenPotatoes home page 
  When  I follow "Add new movie"
  When  I fill in "Title" with "Sample"
  And I press "Save Changes"
  Then I should see "Sample"

