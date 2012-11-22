Feature: View hours

As a student or parent
So I can keep track of my progress
I want to view how many hours I still need to complete this week

Background:
  Given I set up the requirements
  And a student is in the database with email "student@y-scholars"
  And a parent is in the database with student "student@y-scholars" and email "parent@y-scholars"

Scenario: view my hours as a student
  Given a student with email "student@y-scholars" needs 3 hours this week
  Given I am logged in as a student with email "student@y-scholars"
  And I am on my dashboard
  Then I should see "3"
  And I should see "0"

Scenario: view my childs hours
  Given I am logged in as a parent with email "parent@y-scholars"
  And a student with email "student@y-scholars" needs 3 hours this week
  And I am on my dashboard
  Then I should see "3"
  And I should see "0"
