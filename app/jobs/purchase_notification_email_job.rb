class PurchaseNotificationEmailJob < ApplicationJob
  queue_as :default

  def perform(user, account)
    @line_item = user.personal_account.orders.last.line_items.first
  end
end
