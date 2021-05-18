class PurchaseEmailMailer < ApplicationMailer
  default from: "notifications@northstream.live"
  layout "mailer"

  def thankyou_email
    @user = params[:user]
    @account = params[:account]
    @line_item = @user.personal_account.orders.last.line_items.first
    mail(to: @user.email, subject: "Thank you for your purchase!")
  end
end
