Feature: Manage Students

As an Administrator
So I can keep track of all students progress
I want to view how many hours student still need to complete this week

Background:
  Given I set up the requirements
  And a student is in the database with email "student@y-scholars"
  And a tutor is in the database with email "tutor@y-scholars"
  And I am logged in as an administrator with email "test_admin@y-scholars"

Scenario: view list of all students
  Given I am on my dashboard
  When I follow "Manage Students"
  Then I should see "student@y-scholars"

Scenario: view individual student hours
  Given a student with email "student@y-scholars" needs 3 hours this week
  And a student with email "student@y-scholars" has 3 hours logged by "tutor@y-scholars"
  And I am on my dashboard
  And I follow "Manage Students"
  And I follow "student"
  Then I should see "Details about student"
