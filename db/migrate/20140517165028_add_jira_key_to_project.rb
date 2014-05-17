class AddJiraKeyToProject < ActiveRecord::Migration
  def change
    add_column :projects, :jira_key, :string, :default => ""
  end
end
