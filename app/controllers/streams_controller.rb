class StreamsController < ApplicationController
  before_action :authenticate_user_with_sign_up!
  before_action :set_stream, only: [:show, :edit, :update, :destroy]
  before_action :admissible, only: %i[show]
  before_action :streaming, only: %i[show]
  before_action :preview_stream, only: %i[show]
  before_action :require_current_account_admin, only: [:new, :edit, :update, :destroy]

  # GET /streams
  def index
    @pagy, @streams = pagy(Stream.friendly.sort_by_params(params[:sort], sort_direction))

    # We explicitly load the records to avoid triggering multiple DB calls in the views when checking if records exist and iterating over them.
    # Calling @streams.any? in the view will use the loaded records to check existence instead of making an extra DB call.
    @streams.load
  end

  # GET /streams/1
  def show
    @ticket = Ticket.new
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

  def streaming
    @streaming = true
  end

  def preview_stream
    @preview = true
  end

  # Only allow a trusted parameter "white list" through.
  def stream_params
    params.require(:stream).permit(:name, :price, :slug, :status, :stream_date, :stream_key, :stream_rtmp_link, :live_stream_id, :playback_id, :account_id)
  end
end
