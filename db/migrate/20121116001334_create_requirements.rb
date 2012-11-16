class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.string :grade
      t.string :hours

      t.timestamps
    end
  end
end
