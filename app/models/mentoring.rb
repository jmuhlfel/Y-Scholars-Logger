class Mentoring < ActiveRecord::Base
  attr_accessible :start_time, :stop_time, :student_email, :tutor_email
  has_one :tutor, :foreign_key => 'email', :primary_key => 'tutor_email' 
  has_one :student, :foreign_key => 'email', :primary_key => 'student_email'
  
  def hours
    ((self.stop_time - self.start_time)/3600).to_i
  end
end
