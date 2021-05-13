# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  amount     :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  stream_id  :bigint           not null
#
# Indexes
#
#  index_products_on_stream_id  (stream_id)
#
# Foreign Keys
#
#  fk_rails_...  (stream_id => streams.id)
#
require "test_helper"

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
