class StreamsController < ApplicationController
  before_action :authenticate_user_with_sign_up!
  before_action :set_stream, only: [:show, :edit, :update, :destroy]
  before_action :admissible, only: %i[show]
  before_action :require_current_account_admin, only: [:new, :edit, :update, :destroy]

  # GET /streams
  def index
    @pagy, @streams = pagy(Stream.friendly.sort_by_params(params[:sort], sort_direction))
    @purchased = Stream.friendly.select { |stream| stream.users.include?(current_user) }
    # We explicitly load the records to avoid triggering multiple DB calls in the views when checking if records exist and iterating over them.
    # Calling @streams.any? in the view will use the loaded records to check existence instead of making an extra DB call.

    @streams.load
  end

  # GET /streams/1
  def show
    @ticket = Ticket.new
    @order = Order.new
  end

  # GET /streams/new
  def new
    @stream = Stream.new
  end

  # GET /streams/1/edit
  def edit
  end

  # POST /streams
  def create
    @stream = Stream.new(stream_params)
    @stream.account = current_account
    @stream.stream_rtmp_link = "rtmp://global-live.mux.com:5222/app"
    if @stream.save
      redirect_to @stream, notice: "Stream was successfully created."
      CreateLiveStreamJob.perform_later(@stream)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /streams/1
  def update
    if @stream.update(stream_params)
      redirect_to @stream, notice: "Stream was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /streams/1
  def destroy
    @stream.destroy
    redirect_to streams_url, notice: "Stream was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_stream
    @stream = Stream.friendly.find(params[:id])
  end

  def admissible
    current_stream = set_stream
    @admissible = current_stream.users.include?(current_user) ? true : false
  end

  # Only allow a trusted parameter "white list" through.
  def stream_params
    params.require(:stream).permit(:name, :price, :stream_date, :body, :stream_image)
  end
end
