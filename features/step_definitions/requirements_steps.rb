Given /^I change required hours to "(.*?)"$/ do |hours|
  select hours, :from => 'requirements_hours'
  click_button "Update"
end

