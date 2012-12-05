class AlertsMailer < ActionMailer::Base
  def alert_student_notification(student)
    @student = student
    @hours_completed = student.hours_completed
    @required_hours = student.required_hours
    needed_hours = @required_hours.to_i - @hours_completed
    mail(:to => student.email, :subject => "ALERT: You still need to finish #{needed_hours} more hours this week", :sender => "Y-Scholars Tutoring Application")
  end
end
