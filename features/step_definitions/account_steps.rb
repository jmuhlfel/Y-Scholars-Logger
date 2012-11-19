Given /^I am logged in as an administrator with email "(.*?)"$/ do |arg1|
  Administrator.create!({
      :email => arg1,
      :name => 'admin',
      :password => 'abc123',
      :password_confirmation => 'abc123'})
  visit '/login'
  fill_in 'session_email', :with => arg1
  fill_in 'session_password', :with => 'abc123'
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('admin')
  else
    assert page.has_content?('admin')
  end
end

Given /^I am logged in as a tutor with email "(.*?)"$/ do |arg1|
  Tutor.create!({
      :email => arg1,
      :name => 'tutor',
      :password => 'abc123',
      :password_confirmation => 'abc123'})
  visit '/login'
  fill_in 'session_email', :with => arg1
  fill_in 'session_password', :with => 'abc123'
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('tutor')
  else
    assert page.has_content?('tutor')
  end
end

Given /^I am logged in as a student with email "(.*?)"$/ do |arg1|
  visit '/login'
  fill_in 'session_email', :with => arg1
  fill_in 'session_password', :with => 'abc123'
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('test student')
  else
    assert page.has_content?('test student')
  end
end

Given /^I am logged in as a parent with email "(.*?)"$/ do |arg1|
  visit '/login'
  fill_in 'session_email', :with => arg1
  fill_in 'session_password', :with => 'abc123'
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('test parent')
  else
    assert page.has_content?('test parent')
  end
end

Given /^I create an account for a(n)? ([A-Za-z]*) with email "(.*)"$/ do |an, type, email|
  fill_in 'user_email', :with => email
  fill_in 'user_name', :with => 'test name'
  fill_in 'user_password', :with => 'abc123'
  fill_in 'user_password_confirmation', :with => 'abc123'
  select type, :from => 'user_type'
  click_button "Create Account"
end

Given /^I create an account for a Parent of "(.*?)" with email "(.*?)"$/ do |child, email|
  fill_in 'user_email', :with => email
  fill_in 'user_name', :with => 'test name'
  fill_in 'user_password', :with => 'abc123'
  fill_in 'user_password_confirmation', :with => 'abc123'
  fill_in 'user_child_email', :with => child
  select 'Parent', :from => 'user_type'
  click_button "Create Account"
end

Then /^I should see an account email "(.*?)" in the (.*) database$/ do |email, type|
  user = User.find_by_email(email)
  assert user.type == type
end

Given /^a student is in the database with email "(.*?)"$/ do |arg1|
  Student.create!({
      :email => arg1,
      :name => 'student',
      :grade => 10,
      :password => 'abc123',
      :password_confirmation => 'abc123'})
end

Given /^a student with email "(.*?)" and name "(.*?)" is in the database$/ do |email, name|
  Student.create!({
      :email => email,
      :name => name,
      :password => 'abc123',
      :password_confirmation => 'abc123'})
end

Given /^a parent is in the database with student "(.*?)" and email "(.*?)"$/ do |student_email, email|
  Parent.create!({:child_email => student_email,
      :email => email,
      :name => 'test parent',
      :password => 'abc123',
      :password_confirmation => 'abc123'})
end
