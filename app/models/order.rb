# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#
# Indexes
#
#  index_orders_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Order < ApplicationRecord
  belongs_to :account
  has_many :line_items, dependent: :destroy

  def self.create_session(order, url, stream_name, user)
    @domain = if Rails.env.development?
      "revamp.ngrok.io"
    else
      url.include?(".") ? url : ".northstream.live"
    end
    Stripe::Checkout::Session.create({
      payment_method_types: ["card"],
      shipping_address_collection: {
        allowed_countries: ["US"]
      },
      customer_email: user.email,
      shipping_rates: [Rails.application.credentials[:stripe][:shipping_rates]],
      client_reference_id: user.id,
      line_items: [
        {
          price_data: {
            unit_amount: dollars_to_cents(order.line_items.first.amount),
            currency: "usd",
            product_data: {
              name: order.line_items.first.name
            }
          },
          tax_rates: [Rails.application.credentials[:stripe][:tax_rates]],
          quantity: order.line_items.first.quantity
        },
        {
          price_data: {
            unit_amount: admin_fee(order.line_items.first.amount),
            currency: "usd",
            product_data: {
              name: "Processing Fee"
            }
          },
          quantity: 1
        }
      ],
      mode: "payment",
      allow_promotion_codes: true,
      success_url: "https://#{url}#{@domain}/checkout_success?stream_name=#{stream_name}",
      cancel_url: "https://#{url}#{@domain}/streams/#{stream_name}"
    })
  end

  private_class_method

  def self.dollars_to_cents(amount)
    (100 * amount.to_r).to_i
  end

  def self.admin_fee(amount)
    fee = (amount * 0.05)
    dollars_to_cents(fee)
  end
end
