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
  end
  
  def student_dashboard
  end
  
  def guest_dashboard
  end

end
