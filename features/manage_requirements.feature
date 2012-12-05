Feature: Manage Requirements

As an Administrator
So I can manage hours needed for each grade level
I want to view and edit how many hours student in a grade need per week

Background:
  Given I set up the requirements
  And I am logged in as an administrator with email "test_admin@y-scholars"

Scenario: View requirements needed per grade level
  Given I am on my dashboard
  When I follow "Manage requirements"
  Then I should see "Weekly hours requirements"

Scenario: Edit hours for a grade
  Given I am on my dashboard
  And I follow "Manage requirements"
  And I follow "Edit"
  Then I should see "Hours"
  And I should not see "Grade"

Scenario: Make grade 9 hours 8
  Given I am on my dashboard
  And I follow "Manage requirements"
  And I follow "Edit"
  And I change required hours to "8"
  Then I should see "8"
  And I should see "Successfully updated"
