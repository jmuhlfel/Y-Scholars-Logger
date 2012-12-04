class StudentsController < ApplicationController

  def index
    @students = Student.all
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
    @required_hours = @student.requirements.hours
    @total_hours = total_seconds / 3600
    @start_date = start_sun.to_date
    @end_date = @start_date + 7.day
  end
  
  def export_to_csv
    @students = Student.all
    csv_string = CSV.generate do |csv|
      csv << ["student","start", "stop", "email"]
      @students.each do |student|
        @sessions = Mentoring.where("student_email = ?", student.email).all  
        @sessions.each do |session|
          csv << [student.name, session.start_time, session.stop_time, session.tutor.name]
        end 
      end
    end
  end
end