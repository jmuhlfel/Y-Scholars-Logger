Feature: Log a teens hours

As a tutor
So that I can keep track of my students progress
I want to sign in and sign out students

Background:
  Given a student is in the database with email "test@test.com"
  And I am logged in as a tutor with email "tutor@test.com"

Scenario: can see no students if not tutored
  Given I am on my dashboard
  Then I should not see "test@test.com"

Scenario: can see students if they have already been tutored
  Given I have tutored student with email "test@test.com" as "tutor@test.com" before
  And I am on my dashboard
  Then I should see "test@test.com"

Scenario: sign in a student
  Given I have tutored student with email "test@test.com" as "tutor@test.com" before
  And I am on my dashboard
  And I press "Sign In"
  Then I should see "test@test.com" 
  And a student with email "test@test.com" should be signed in
  

Scenario: sign out a student
  Given student with email "test@test.com" is signed in with "tutor@test.com"
  And I am on my dashboard
  And I press "Sign Out"
  Then I should see "test@test.com"
  And a student with email "test@test.com" should not be signed in
