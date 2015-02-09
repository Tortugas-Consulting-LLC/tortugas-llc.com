class RemoveJiraKeyFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :jira_key, :string, :default => ""
  end
end
