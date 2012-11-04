class CreateMentorings < ActiveRecord::Migration
  def change
    create_table :mentorings do |t|
      t.string :tutor_email
      t.string :student_email
      t.timestamp :start_time
      t.timestamp :stop_time

      t.timestamps
    end
  end
end
