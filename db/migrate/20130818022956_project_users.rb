class ProjectUsers < ActiveRecord::Migration
  def change
    create_table(:project_users) do |t|
      t.belongs_to :user
      t.belongs_to :project
    end
  end
end
