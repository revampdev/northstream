class Api::V1::OrdersController < Api::BaseController
  def order_completed
    PurchaseEmailMailer.with(user: current_user, account: current_tenant).thankyou_email.deliver_later
  end
end
