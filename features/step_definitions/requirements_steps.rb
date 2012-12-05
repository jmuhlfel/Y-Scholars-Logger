Given /^I change required hours to "(.*?)"$/ do |hours|
  select hours, :from => 'requirements_hours'
  click_button "Update"
end

Given /^a student with email "(.*?)" needs ([0-9]) hours this week$/ do |email, hours|
  student = Student.find_by_email(email)
  requirement = Requirements.find_by_grade(student.grade)
  requirement.hours = hours.to_str
  requirement.save!
end

Given /^I view a student with email "(.*)"$/ do |email|
  student = Student.find_by_email(email)
  visit "/students/#{student.id}"
end

Given /^I put them on the improvement program with (\d+) hours$/ do |hours|
  select hours, :from => 'student_custom_hours'
  click_button "Set Required Hours"
end

Then /^the student with email "(.*?)" weekly hour requirement should be (\d+) hours$/ do |email, hours|
  student = Student.find_by_email(email)
  assert student.required_hours == hours
end

Given /^the student with email "(.*?)" is on the improvement program with (.+) hours$/ do |email, hours|
  student = Student.find_by_email(email)
  student.custom_hours = hours
  student.save
end

Given /^I take them off the improvement program$/ do
  click_button "Clear Custom Hours"
end

Then /^the student with email "(.*?)" weekly hour requirement should default hours$/ do |email|
  steps %Q{
    Given I view a student with email "bad@y-scholars"
    And I put them on the improvement program with 5 hours
    Then the student with email "bad@y-scholars" weekly hour requirement should be 5 hours
  }
end
