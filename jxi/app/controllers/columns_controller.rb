class ColumnsController < ApplicationController
  def index
    @table = Table.find(params[:table_id])
    @columns = @table.columns
  end

  def show
    @table = Table.find(params[:table_id])
    @column = @table.columns.find(params[:id])
  end

  def new
    @table = Table.find(params[:table_id])
    @column = @table.columns.build
  end

  def create
    @table = Table.find(params[:table_id])
    @column = @table.columns.build(params[:column])
    if @column.save
      redirect_to table_column_url(@table, @column)
    else
      render :action => "new"
    end
  end

  def edit
    @table = Table.find(params[:table_id])
    @column = @table.columns.find(params[:id])
  end

  def update
    @table = Table.find(params[:table_id])
    @column = Column.find(params[:id])
    if @column.update_attributes(params[:column])
      redirect_to table_column_url(@table, @column)
    else
      render :action => "edit"
    end
  end

  def destroy
    @table = Table.find(params[:table_id])
    @column = Column.find(params[:id])
    @column.destroy

    respond_to do |format|
      format.html { redirect_to table_columns_path(@table) }
      format.xml  { head :ok }
    end
  end
end
