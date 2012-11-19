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

Given /^student with email (.*?) is signed in with (.*?)$/ do |email, tutor_email|
  Mentoring.create!({
    :student_email => email,
    :tutor_email => tutor_email,
    :start_time => DateTime.new(2012,11,9,12,0,0),
  })
end

Given /^a student with email "(.*?)" needs ([0-9]) hours this week$/ do |email, hours|
  student = Student.find_by_email(email)
  requirement = Requirement.find_by_hours(hours)
  assert student[:grade] == requirement[:grade]
end
