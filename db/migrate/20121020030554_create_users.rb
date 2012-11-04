class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :password_digest
      t.string :type
      t.string :child_email
      t.string :grade
      t.string :hours_required
      t.timestamps
    end
  end
end
