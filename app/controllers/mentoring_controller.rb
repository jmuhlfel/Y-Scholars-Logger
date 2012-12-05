class MentoringController < ApplicationController

  def signin
    student = Student.find_by_email(params[:student_email])
    raise "Student already signed in" unless not student.is_signed_in?
    raise "You don't have permission to sign students in" unless current_user.is_tutor? or current_user.is_admin?
    #create a new mentoring session
    Mentoring.create!({
      :student_email => params[:student_email],
      :tutor_email => current_user.email,
      :start_time => DateTime.strptime(params[:time], "%H:%M")
    })
    redirect_to :dashboard
  end
  
  def signout
    student = Student.find_by_email(params[:student_email])
    raise "Student not signed in" unless student.is_signed_in?
    raise "You don't have permission to sign students out" unless current_user.is_tutor? or current_user.is_admin?
    #student sign out logic here
    mentorings = Mentoring.where("student_email = ? AND tutor_email = ? AND stop_time IS NULL", params[:student_email], current_user.email).order("stop_time ASC")
    raise "Student not being tutored" unless not mentorings.empty?
    mentoring = mentorings.first
    # their current mentoring session is stopped now and saved
    mentoring.stop_time = DateTime.strptime(params[:time], "%H:%M")
    mentoring.save    
    redirect_to :dashboard
  end

end
