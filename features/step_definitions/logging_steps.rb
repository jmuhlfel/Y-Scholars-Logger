Given /^I have tutored student with email "(.*?)" as "(.*?)" before$/ do |email, tutor_email|
  Mentoring.create!({
    :student_email => email,
    :tutor_email => tutor_email,
    :start_time => DateTime.new(2012,11,4,12,0,0),
    :stop_time => DateTime.new(2012,11,4,14,0,0)
  })
end

Given /^I make mentoring session between "(.*?)" and "(.*?)"$/ do |arg1, arg2|
  user1 = User.find_by_email(arg1)
  email = (user1.is_student? ? arg1 : arg2)
end

Given /^student with email "(.*?)" is signed in with "(.*?)"$/ do |email, tutor_email|
  Mentoring.create!({
    :student_email => email,
    :tutor_email => tutor_email,
    :start_time => DateTime.new(2012,11,9,12,0,0),
  })
end

Given /^a student with email "(.*?)" needs ([0-9]) hours this week$/ do |email, hours|
  student = Student.find_by_email(email)
  requirement = Requirements.find_by_grade(student.grade)
  requirement.hours = hours.to_str
  requirement.save!
end

Then /^a student with email "(.*?)" should( not)? be signed in$/ do |email, not_signed_in|
  student = Student.find_by_email(email)
  signed_in = student.is_signed_in?
  if not_signed_in
    assert (not signed_in)
  else
    assert signed_in
  end
end

Given /^I search for "(.*?)"$/ do |arg1|
  fill_in 'dashboard_query', :with => arg1
  click_button 'Search'
end

Given /^a student with email "(.*?)" has (\d+) hours logged by "(.*?)"$/ do |student, hours, tutor|
  now = DateTime.now()
  Mentoring.create!({
    :student_email => student,
    :tutor_email => tutor,
    :start_time => now,
    :stop_time => now - hours.to_i.hours
  })
  
end

