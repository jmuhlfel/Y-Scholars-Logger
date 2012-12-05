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
    redirect_to students_path
  end
end
