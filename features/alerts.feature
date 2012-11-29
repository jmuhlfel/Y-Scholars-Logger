Feature: Alerts

As a student or parent
So that I can have a reminder when I need more hours before the week ends
I want to be sent an email with my remaining hours

Background:
  Given a student is in the database with email "bad@y-scholars"
  And I set up the requirements
  And a parent is in the database with student "bad@y-scholars" and email "parent@y-scholars"
  And a student is in the database with email "good@y-scholars"
  And I am logged in as an administrator with email "test_admin@y-scholars"

Scenario: alerts necessary for account are sent
  Given a student with email "bad@y-scholars" needs 3 hours this week
  And I am on the alerts page
  Then I should see "bad@y-scholars"

Scenario: alerts are not sent when hours completed
  Given a student with email "good@y-scholars" needs 0 hours this week
  And I am on the alerts page
  Then I should not see "good@y-scholars"

Scenario: alert email is sent
  Given a student with email "bad@y-scholars" needs 3 hours this week
  And I am on the alerts page
  And I send an alert for student "bad@y-scholars"
  Then "bad@y-scholars" should receive an email
  And "parent@y-scholars" should receive an email
