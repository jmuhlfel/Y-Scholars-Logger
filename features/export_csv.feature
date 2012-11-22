Feature: Make spreadsheet

As an admin
So I can keep track of records
I would like to be able to convert users sheet to csv

Background:
  Given a student is in the database with email "test@test.com" and name "fhgwghads"
  And a tutor is in the database with email "tutor@test.com"
  And I am logged in as an administrator with email "test_admin@y-scholars"

Scenario: view users CSV
  Given I am on the users page
  And I follow "Export To CSV"
  Then I should see "test@test.com"
  And I should see "tutor@test.com"
  And I should see "test_admin@y-scholars"
  And I should see "fhgwghads"
