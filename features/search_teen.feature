Feature: Lookup a student

As a tutor
So that I can find and monitor my students
I want to be able to search for them

Background:
  Given a student with email "test@y-scholars" and name "Test student" is in the database
  And I am logged in as a tutor with email "tutor@test"
  And I make mentoring session between "tutor@test" and "test@y-scholars"

Scenario: search for a student
  Given I am on my dashboard
  And I search for "Test student"
  Then I should be on my dashboard
  And I should see "test@y-scholars"

Scenario: search for a non-existent student
  Given I am on my dashboard
  And I search for "Fake student"
  Then I should not see "Fake student"
