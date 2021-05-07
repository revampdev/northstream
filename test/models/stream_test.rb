# == Schema Information
#
# Table name: streams
#
#  id               :bigint           not null, primary key
#  name             :string
#  price            :integer
#  slug             :string
#  status           :string
#  stream_date      :datetime
#  stream_key       :string
#  stream_rtmp_link :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  account_id       :bigint           not null
#  live_stream_id   :string
#  playback_id      :string
#
# Indexes
#
#  index_streams_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
require "test_helper"

class StreamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
