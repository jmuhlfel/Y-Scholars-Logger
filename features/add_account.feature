Feature: Add an account

As an administrator
So that I can add people to my program
I want to add a student, parent, or tutor to our Teen Program database

Background:
  Given I am logged in as an administrator with email "test_admin@y-scholars"

Scenario: add a student
  Given I am on the add_account page
  And I create an account for a student with email "test@y-scholars"
  Then I should see an account email "test@y-scholars" in the student database

Scenario: add a parent
  Given I am on the add_account page
  And a student is in the database with email "test@y-scholars"
  And I create an account for a parent of test@y-scholars with email "test-parent@y-scholars"
  Then I should see an account email "test-parent@y-scholars" in the parent database

Scenario: add a tutor
  Given I am on the add_account page
  And I create an account for a tutor with email "tutor@y-scholars"
  Then I should see an account email "tutor@y-scholars" in the tutor database
