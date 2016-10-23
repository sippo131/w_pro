class CreateHides < ActiveRecord::Migration
  def change
    create_table :hides do |t|
      t.integer :user_id
      t.integer :hide_skill_id

      t.timestamps null: false
    end
  end
end
