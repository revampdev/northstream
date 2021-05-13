class ProcessOrderCheckoutJob < ApplicationJob
  queue_as :default

  def perform(order, url, stream_name)
    # Do something later
    session = Stripe::Checkout::Session.create({
      payment_method_types: ["card"],
      line_items: [
        {
          price_data: {
            unit_amount: dollars_to_cents(order.line_items.first.amount),
            currency: "usd",
            product_data: {
              name: order.line_items.first.name

            }
          },
          quantity: order.line_items.first.quantity
        }
      ],
      mode: "payment",
      success_url: "#{url}/streams/#{stream_name}",
      cancel_url: "#{url}/streams/#{stream_name}"
    })
    session.id
  end

  private

  def dollars_to_cents(amount)
    (100 * amount.to_r).to_i
  end
end
