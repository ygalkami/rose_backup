class TablesController < ApplicationController
  def index
    @database = Database.find(params[:database_id])
    @tables = @database.tables
  end

  def show
    @database = Database.find(params[:database_id])
    @table = @database.tables.find(params[:id])
  end

  def new
    @database = Database.find(params[:database_id])
    @table = @database.tables.build
  end

  def create
    @database = Database.find(params[:database_id])
    @table = @database.tables.build(params[:table])
    if @table.save
      redirect_to database_table_url(@database, @table)
    else
      render :action => "new"
    end
  end

  def edit
    @database = Database.find(params[:database_id])
    @table = @database.tables.find(params[:id])
  end

  def update
    @database = Database.find(params[:database_id])
    @table = Table.find(params[:id])
    if @table.update_attributes(params[:table])
      redirect_to database_table_url(@database, @table)
    else
      render :action => "edit"
    end
  end

  def destroy
    @database = Database.find(params[:database_id])
    @table = Table.find(params[:id])
    @table.destroy

    respond_to do |format|
      format.html { redirect_to database_tables_path(@database) }
      format.xml  { head :ok }
    end
  end
end
