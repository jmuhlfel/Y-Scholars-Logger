class Student < User
  has_one :requirements, :foreign_key => 'grade', :primary_key => 'grade'
  
  
  def is_signed_in?
    mentorings = Mentoring.where("student_email = ?", self.email).order("stop_time ASC")
	mentor = false
    unless mentorings.empty?
	  mentorings.each do |mentoring|
	    if mentoring.stop_time.nil?
		  mentor = true
		end
      end
      unless mentor
        false
      else
        true
      end
    else
      false
    end
  end
  
  def current_mentoring_session
    mentorings = Mentoring.where("student_email = ? AND stop_time IS NULL", self.email)
    return mentorings.first
  end
  
  def required_hours
    Requirements.find_by_grade(self.grade)
  end
  

end
