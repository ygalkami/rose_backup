class RenameColumn < ActiveRecord::Migration
  def self.up
		rename_column :columns, :type, :column_type
  end

  def self.down
		rename_column :columns, :column_type, :type
  end
end
