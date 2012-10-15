Feature: Set a teen on the improvement program

As an administrator
So that I can customize a student's tutoring program
I want to change a students status and required weekly hours

Background:
  Given a student is in the database with email "bad@y-scholars"
  And a parent is in the database with student "bad@y-scholars" and email "parent@y-scholars"
  And a student is in the database with email "good@y-scholars"
  And I am logged in as an administrator with email "test_admin@y-scholars"

Scenario: put a student on the improvement program
  Given I am on a student with email "bad@y-scholars" page
  And I put them on the improvement program with 5 hours
  Then the student with email "bad@y-scholars" weekly hour requirement should be 5 hours

Scenario: take a student off the improvement program
  Given I am on a student with email "bad@y-scholars" page
  And the student with email "bad@y-scholars" is on the improvement program
  And I take them off the improvement program
  Then the student with email "bad@y-scholars" weekly hour requirement should default hours
