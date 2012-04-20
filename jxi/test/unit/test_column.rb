# Make sure we test DAVE

# Includes functions that allow Unit Testing
# Reference: http://guides.rubyonrails.org/testing.html
require 'test/test_helper'

# Includes the functions that allow Mocking
# Reference: http://blog.floehopper.org/articles/2006/09/01/mocha-quickstart#fn1
require 'mocha'

class ColumnTest < ActiveSupport::TestCase
	def setup
		@userA = Factory.create(:user)
		@databaseA = Factory.create(:database, :user => @userA)
		@tableA = Factory.create(:table, :database => @databaseA)
		@userB = Factory.create(:user)
		@userAdmin = Factory.create(:user)
		@userTA = Factory.create(:user)
		@columnA = Factory.create(:column, :table => @tableA)
	end

  def test_add_all_criteria
    column = Factory.create(:column)
    assert column.save, 'Could not save a new Column!'
  end

  def test_should_not_save_with_no_name
    # Create a new column with no name
    column = Factory.create(:column)
    # Grab the ID from that column and increment it by one
    prev_column_id = Integer(column.name.match(/\d+/)[0])
    prev_column_id += 1
    # Add another new column without name (testing to see)
    # if the first one and this one were both successfylly added
    # with no names
    new_column = Factory.build(:column)
    assert_equal new_column.name, 'Column'+prev_column_id.to_s, 'Saved a new Column with no name!'  
  end
  
  def test_should_not_save_with_no_column_type
    column = Factory.build(:column, :column_type => nil)
    assert !column.save, 'Saved a new Column with no column_type!'    
  end
  
  def test_should_not_save_with_no_null
    column = Factory.build(:column, :null => nil)
    assert !column.save, 'Saved a new Column with no null!'    
  end

  def test_should_not_save_with_no_table
    column = Factory.build(:column, :table => nil)
    assert !column.save, 'Saved a new Column with no user!'
  end

  def test_should_not_save_column_with_same_name
    table = Factory.create(:table)
    column = Factory.create(:column, :name => 'Same Name', :table => table)
    column2 = Factory.build(:column, :name => 'Same Name', :table => table)
    assert !column2.valid?, 'Saved a column with a duplicate name!'
  end

  def test_delete_column
    column = Factory.create(:column)
    assert column.destroy, 'Unable to destroy column'
  end

#destroy
	def test_destroy_column
		assert @columnA.destroy_column(@userA), 'User was unable to destroy column'
	end

	def test_destroy_someone_elses_column
		assert !@columnA.destroy_column(@userB), 'User could delete someone else\'s column'
	end

#edit
  def test_edit_own_column
    assert @columnA.edit_column(@userA), 'Could not update column'
  end
		
	def test_edit_someone_elses_column
    assert !@columnA.edit_column(@userB), 'User could update someone else\'s column'
  end

	def admin_can_edit_someone_elses_column
		assert @columnA.edit_column(@userAdmin), 'Admin could edit someone else\'s column'
	end

	def ta_cant_edit_someone_elses_column
		assert !@columnA.edit_column(@userTA), 'TA could edit someone else\'s column'
	end

	def test_edit_own_column
		assert @columnA.update_attributes(:name => 'new column'), 'Could not update column'
	end

#view
	def test_view_own_column
    assert @columnA.view_column(@userA), 'Could not view column'
  end
		
	def test_view_someone_elses_column
    assert !@columnA.view_column(@userB), 'User could view someone else\'s column'
  end

	def admin_can_view_someone_elses_column
		assert !@columnA.view_column(@userAdmin), 'Admin not could view someone else\'s column'
	end

	def ta_cant_view_someone_elses_column
		assert !@columnA.view_column(@userTA), 'TA could view someone else\'s column'
	end

end
