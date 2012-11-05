class DashboardController < ApplicationController

  def index
    if current_user
      #check for search query
      if params[:dashboard] and not params[:dashboard][:query].empty?
        @query = params[:dashboard][:query]
      end
      
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
    mentoring_sessions = Mentoring.where("tutor_email = ?", current_user.email).order("stop_time DESC")
    unless mentoring_sessions.nil?
      student_emails = mentoring_sessions.pluck(:student_email)
      if @query
        @students = Student.where("email IN (?) AND (name LIKE ? OR email LIKE ? OR grade LIKE ?)",
                                  student_emails, "%#{@query}%","%#{@query}%","%#{@query}%")
      else
        @students = Student.find_all_by_email(student_emails)
      end
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
