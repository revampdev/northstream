class StaticController < ApplicationController
  def index
  end

  def about
  end

  def checkout
    @checkout_id = params[:session_id]
    @public_key = Rails.application.credentials.config[:stripe][:public_key]
  end

  def checkout_success
    PurchaseEmailMailer.with(user: current_user, account: current_tenant).thankyou_email.deliver_later
    redirect_to stream_path(params[:stream_name]), notice: "Thank you for your purchase!"
  end

  def pricing
    redirect_to root_path, alert: t(".no_plans") unless Plan.visible.without_free.exists?
  end

  def terms
  end

  def privacy
  end
end
