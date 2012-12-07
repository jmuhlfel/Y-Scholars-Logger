class MentoringController < ApplicationController

  def signin
    student = Student.find_by_email(params[:student_email])
    if student.is_signed_in?
      flash[:error] = "Student already signed in"
    elsif !(current_user.is_tutor? or current_user.is_admin?)
      flash[:error] = "You don't have permission to sign students in"
    else
      #create a new mentoring session
      Mentoring.create!({
        :student_email => params[:student_email],
        :tutor_email => current_user.email,
        :start_time => DateTime.strptime(params[:time], "%H:%M")
      })
      flash[:notice] = "#{student.name} successfully signed in"
    end
    redirect_to :dashboard
  end
  
  def signout
    student = Student.find_by_email(params[:student_email])
    if !student.is_signed_in?
      flash[:error] = "Student not signed in"
    elsif !(current_user.is_tutor? or current_user.is_admin?)
      flash[:error] = "You don't have permission to sign students out"
    else
      #student sign out logic here
      mentorings = Mentoring.where("student_email = ? AND tutor_email = ? AND stop_time IS NULL", params[:student_email], current_user.email).order("stop_time ASC")
      if mentorings.empty?
        flash[:error] = "Student not being tutored"
      else
        mentoring = mentorings.first
        # their current mentoring session is stopped now and saved
        mentoring.stop_time = DateTime.strptime(params[:time], "%H:%M")
        if mentoring.start_time > mentoring.stop_time
          flash[:error] = "Invalid signout time"
        else
          mentoring.save
          flash[:notice] = "#{student.name} successfully signed out"
        end
      end
    end   
    redirect_to :dashboard
  end

end
