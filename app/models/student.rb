class Student < User
  # attr_accessible :title, :body
  
  def is_signed_in?
    mentorings = Mentoring.where("student_email = ?", self.email).order("start_time DESC")
    unless mentorings.empty?
      unless mentorings.first.stop_time.nil?
        false
      else
        true
      end
    else
      false
    end
  end
end
