class LineItemsController < ApplicationController
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  def index
    @pagy, @line_items = pagy(LineItem.sort_by_params(params[:sort], sort_direction))

    # We explicitly load the records to avoid triggering multiple DB calls in the views when checking if records exist and iterating over them.
    # Calling @line_items.any? in the view will use the loaded records to check existence instead of making an extra DB call.
    @line_items.load
  end

  # GET /line_items/1
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  def create
    @line_item = LineItem.new(line_item_params)

    if @line_item.save
      redirect_to @line_item, notice: "Line item was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /line_items/1
  def update
    if @line_item.update(line_item_params)
      redirect_to @line_item, notice: "Line item was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /line_items/1
  def destroy
    @line_item.destroy
    redirect_to line_items_url, notice: "Line item was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def line_item_params
    params.require(:line_item).permit(:name, :description, :amount)
  end
end
