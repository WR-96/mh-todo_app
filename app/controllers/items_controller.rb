class ItemsController < ApplicationController
  before_action :set_items
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET lists/1/items/new
  def new
    @item = @list.items.build
  end

  # GET lists/1/items/1/edit
  def edit
  end

  # POST lists/1/items
  def create
    @item = @list.items.build(item_params)

    if @item.save
      redirect_to(list_path(@item.list), notice: 'Item was successfully created.')
    else
      render action: 'new'
    end
  end

  # PUT lists/1/items/1
  def update
    if @item.update_attributes(item_params)
      redirect_to(list_path(@item.list), notice: 'Item was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE lists/1/items/1
  def destroy
    @item.destroy

    redirect_to list_path(@item.list)
  end

  def change_status
    @item.completed = !@item.completed 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_items
      @list = List.find(params[:list_id])
    end

    def set_item
      @item = @list.items.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:title, :completed, :list_id)
    end
end
