Feature: Set a teen on the improvement program

As an administrator
So that I can customize a student's tutoring program
I want to change a students status and required weekly hours

Background:
  Given a student is in the database with email "bad@y-scholars"
  And I set up the requirements
  And I am logged in as an administrator with email "test_admin@y-scholars"

Scenario: put a student on the improvement program
  Given I view a student with email "bad@y-scholars"
  And I put them on the improvement program with 5 hours
  Then the student with email "bad@y-scholars" weekly hour requirement should be 5 hours

Scenario: take a student off the improvement program
  Given I view a student with email "bad@y-scholars"
  And I put them on the improvement program with 5 hours
  And I press "Clear Custom Hours"
  Then the student with email "bad@y-scholars" weekly hour requirement should default hours
