class CreateColumns < ActiveRecord::Migration
  def self.up
    create_table :columns do |t|
      t.string :name
      t.string :column
      t.boolean :null
      t.references :table

      t.timestamps
    end
  end

  def self.down
    drop_table :columns
  end
end
