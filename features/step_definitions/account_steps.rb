Given /^I am logged in as an administrator with email "(.*?)"$/ do |arg1|
  User.create!({:child_email => '',
      :email => arg1,
      :name => 'admin',
      :password => 'abc123',
      :password_confirmation => 'abc123',
      :type => 'Administrator'})
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
  User.create!({:child_email => '',
      :email => arg1,
      :name => 'student',
      :password => 'abc123',
      :password_confirmation => 'abc123',
      :type => 'Student'})
end

