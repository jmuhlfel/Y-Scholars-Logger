Feature: Log a teens hours

As a tutor
So that I can keep track of my students progress
I want to sign in and sign out students

Background:
  Given a student is in the database with email "test@y-scholars"
  And I am logged in as a tutor with email "tutor@test"

Scenario: can see nothing if no students
  Given I am on my dashboard
  Then I should not see "test@y-scholars"

Scenario: can see students if assigned them
  Given I make mentoring session between "tutor@test" and "test@y-scholars"
  And I am on my dashboard
  Then I should see "test@y-scholars"

Scenario: sign in a student
  Given I make mentoring session between "tutor@test" and "test@y-scholars"
  And I am on my dashboard
  And I press "Sign In"
  Then I should see "test@y-scholars" 
  

Scenario: sign out a student
  Given I make mentoring session between "tutor@test" and "test@y-scholars"
  And I am on my dashboard
  And "test@y-scholars" has been signed in
  And I press "Sign Out"
  Then I should see "test@y-scholars"
