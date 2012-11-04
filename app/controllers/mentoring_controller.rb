class MentoringController < ApplicationController

  def signin
    student = Student.find_by_email(params[:student_email])
    raise unless not student.is_signed_in?
    #add student sign in logic here
    redirect_to :dashboard
  end
  
  def signout
    student = Student.find_by_email(params[:student_email])
    raise unless student.is_signed_in?
    #add student sign out logic here
    redirect_to :dashboard
  end

end
