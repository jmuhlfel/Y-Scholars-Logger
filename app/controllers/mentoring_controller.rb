class MentoringController < ApplicationController

  def signin
    student = Student.find_by_email(params[:student_email])
    raise "Student already signed in" unless not student.is_signed_in?
    raise "You don't have permission to sign students in" unless current_user.is_tutor? or current_user.is_admin?
    #add student sign in logic here
    redirect_to :dashboard
  end
  
  def signout
    student = Student.find_by_email(params[:student_email])
    raise "Student not signed in" unless student.is_signed_in?
    raise "You don't have permission to sign students out" unless current_user.is_tutor? or current_user.is_admin?
    #add student sign out logic here
    redirect_to :dashboard
  end

end
