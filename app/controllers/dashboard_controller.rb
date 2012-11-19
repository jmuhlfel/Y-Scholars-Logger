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
    now = DateTime.now
    start_sun = now - now.wday
    @sessions = Mentoring.where("student_email = ? AND stop_time > ? AND stop_time < ?", current_user.email, start_sun, now).all
    total_seconds = 0
    @sessions.each do |session|
      total_seconds += session.stop_time - session.start_time
    end
    @required_hours = current_user.requirements.hours
    @total_hours = total_seconds / 3600
    @start_date = start_sun.to_date
    @end_date = @start_date + 7.day
    red = "#f00"
    green = "#00FF00"
    if @total_hours / @required_hours.to_i >= 1
      @color = green
    else
      @color = red
    end
    render :student_dashboard
  end
  
  def parent_dashboard
    render :parent_dashboard
  end
  
  def guest_dashboard
    redirect_to :login
  end

end
