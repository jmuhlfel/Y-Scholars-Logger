Feature: Log a teens hours

As a tutor
So that I can keep track of my students progress
I want to sign in and sign out students

Background:
  Given a student is in the database with email test@y-scholars
  And I am logged in as a tutor with email tutor@test

Scenario: sign in a student
  Given I sign in a student with email test@y-scholars
  Then I should see test@y-scholars on my page
  

Scenario: sign out a student
  Given a student with email test@y-scholars has been signed in for 2 hours under tutor tutor@test
  And I sign out a student with email test@y-scholars
  Then I should not see test@y-scholars
  And the student test@y-scholars should have 2 hours of tutoring
