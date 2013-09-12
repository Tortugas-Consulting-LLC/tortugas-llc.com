class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :for
      t.text :description
      t.decimal :amount
      t.integer :project_id
      t.integer :user_id

      t.timestamps
    end
  end
end
