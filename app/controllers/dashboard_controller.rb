class DashboardController < ApplicationController

  def index
    if current_user
      if current_user.is_admin?
        admin_dashboard
      elsif current_user.is_tutor?
        tutor_dashboard
      else
        student_dashboard
      end
    else
      guest_dashboard
    end
  end
  
  def admin_dashboard
    @students = Student.all
    render :admin_dashboard
  end
  
  def tutor_dashboard
    mentoring_sessions = Mentoring.find_by_tutor_email(current_user.email)
    if mentoring_sessions
       @students = @mentoring_sessions.student.all
    else
       @students = []
    end
    render :tutor_dashboard
  end
  
  def student_dashboard
    render :student_dashboard
  end
  
  def parent_dashboard
    render :parent_dashboard
  end
  
  def guest_dashboard
    redirect_to :login
  end

end
