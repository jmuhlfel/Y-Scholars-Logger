class Student < User
  attr_accessible :grade
  has_one :requirements, :foreign_key => 'grade', :primary_key => 'grade'
  
  validates :grade, :presence => true
  
  
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
  
  def required_hours
    Requirements.find_by_grade(self.grade)
  end
  

end
