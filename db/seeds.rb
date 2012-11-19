# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Administrator.create!({
  :email => "admin@y-scholars",
  :name => 'Administrator',
  :password => 'abc123',
  :password_confirmation => 'abc123'
})

Tutor.create!({
  :email => "tutor@test.com",
  :name => "Tutor Test",
  :password => 'abc123',
  :password_confirmation => 'abc123'
})

Student.create!({
  :email => "test@test.com",
  :name => "Test Student",
  :password => 'abc123',
  :password_confirmation => 'abc123',
  :grade => "10"
})

Student.create!({
  :email => "susan@test.com",
  :name => "Susan the Student",
  :password => 'abc123',
  :password_confirmation => 'abc123',
  :grade => "9"
})

Mentoring.create!({
  :student_email => "test@test.com",
  :tutor_email => "tutor@test.com",
  :start_time => DateTime.new(2012,11,1,16,0,0),
  :stop_time => DateTime.new(2012,11,1,18,0,0)
})

Mentoring.create!({
  :student_email => "susan@test.com",
  :tutor_email => "tutor@test.com",
  :start_time => DateTime.new(2012,11,2,16,0,0)
})

# Default hours for different grades
Requirements.create!({
  :grade => "9",
  :hours => "4"
})
Requirements.create!({
  :grade => "10",
  :hours => "4"
})
Requirements.create!({
  :grade => "11",
  :hours => "3"
})
Requirements.create!({
  :grade => "12",
  :hours => "2"
})
