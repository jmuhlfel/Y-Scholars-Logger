class StudentsController < ApplicationController

  def index
    @students = Student.scoped
    if params[:sort] == "name"
      @students = @students.order("name")
    elsif params[:sort] == "grade"
      @students = @students.order("grade")
    elsif params[:sort] == "hours_completed"
      @students = @students.sort_by(&:hours_completed)
    end
    respond_to do |format|
      format.html
      format.csv { send_data self.export_to_csv }
    end
  end

  def show
    id = params[:id]
    @student = Student.find(id)
    now = DateTime.now
    start_sun = (now - now.wday).beginning_of_day
    @sessions = Mentoring.where("student_email = ? AND stop_time >= ? AND stop_time <= ?", "#{@student.email}", start_sun, now).all
    total_seconds = 0
    @sessions.each do |session|
      total_seconds += session.stop_time - session.start_time
    end
    @required_hours = @student.required_hours
    @total_hours = total_seconds / 3600
    @start_date = start_sun.to_date
    @end_date = @start_date + 7.day
  end
  
  def update
    student = Student.find_by_id(params["id"])
    if params['commit'] == "Clear Custom Hours"
      student.update_attribute(:custom_hours, nil)
      flash[:notice] = "Custom required hours for #{student.name} cleared"
    elsif params['student']['custom_hours'].present?
      student.update_attribute(:custom_hours, params['student']['custom_hours'])
      flash[:notice] = "Custom required hours for #{student.name} set to #{student.custom_hours}"
    end
    redirect_to student_path
  end
  
  def clear_custom_hours
    student = Student.find_by_id(params["id"])
   
    redirect_to student_path
  end
  
  def export_to_csv
    @students = Student.all
    csv_string = CSV.generate do |csv|
      csv << ["Student name","grade","total"]
      @students.each do |student|
        now = DateTime.now
        start_sun = (now - now.wday).beginning_of_day
        @sessions = Mentoring.where("student_email = ? AND stop_time >= ? AND stop_time <= ?", student.email, start_sun, now).all
        total_seconds = 0
        @sessions.each do |session|
          total_seconds += session.stop_time - session.start_time
        end
        @total_hours = total_seconds / 3600 
        csv << [student.name, student.grade, "#{@total_hours}"]
      end
    end
  end
  
  def send_alert
    flash[:notice] = "Sent an alert to student #{params[:student_email]}"
    student = Student.find_by_email(params[:student_email])
    AlertsMailer.alert_student_notification(student).deliver
    redirect_to students_path
  end
end
