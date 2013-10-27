class RenameEventForColumn < ActiveRecord::Migration
  def self.up
    rename_column :events, :for, :done_on
  end

  def self.down
    rename_column :events, :done_on, :for
  end
end
