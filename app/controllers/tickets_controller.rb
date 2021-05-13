class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :destroy]

  # GET /tickets
  def index
    @pagy, @tickets = pagy(current_user.tickets.sort_by_params(params[:sort], sort_direction))

    # We explicitly load the records to avoid triggering multiple DB calls in the views when checking if records exist and iterating over them.
    # Calling @tickets.any? in the view will use the loaded records to check existence instead of making an extra DB call.
    @tickets.load
  end

  # GET /tickets/1
  def show
  end

  # GET /tickets/new
  # def new
  #   @ticket = Ticket.new
  # end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.user = current_user
    loop do
      @ticket.token = SecureRandom.hex(10)
      break unless Ticket.where(token: @ticket.token).exists?
    end
    if @ticket.save
      current_user.personal_account.charge(dollars_to_cents(@ticket.amount))
      redirect_to @ticket.stream, notice: "Ticket was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tickets/1
  # def update
  #   if @ticket.update(ticket_params)
  #     redirect_to @ticket, notice: "Ticket was successfully updated."
  #   else
  #     render :edit, status: :unprocessable_entity
  #   end
  # end

  # DELETE /tickets/1
  def destroy
    @ticket.destroy
    redirect_to tickets_url, notice: "Ticket was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  # Conver dollars to pennies for Stripe
  def dollars_to_cents(amount)
    (100 * amount.to_r).to_i
  end

  # Only allow a trusted parameter "white list" through.
  def ticket_params
    params.require(:ticket).permit(:amount, :stream_id)
  end
end
