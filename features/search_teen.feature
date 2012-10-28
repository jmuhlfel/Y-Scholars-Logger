Feature: Lookup a student

As a tutor
So that I can find and monitor my students
I want to be able to search for them

Background:
  Given a student is in the database with email "test@y-scholars"
  And the student with email "test@y-scholars" has name "Test student"
  And I am logged in as a tutor with email "tutor@test"

Scenario: search for a student
  Given I am on the search student page
  And I search for "Test student"
  Then I should see "test@y-scholars"

Scenario: search for a non-existent student
  Given I am on the search student page
  And I search for "Fake student"
  Then I should see "Student could not be found"
