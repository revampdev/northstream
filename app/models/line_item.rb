# == Schema Information
#
# Table name: line_items
#
#  id          :bigint           not null, primary key
#  amount      :integer
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  order_id    :bigint           not null
#
# Indexes
#
#  index_line_items_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
class LineItem < ApplicationRecord
  belongs_to :order
end
