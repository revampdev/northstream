# == Schema Information
#
# Table name: tickets
#
#  id         :bigint           not null, primary key
#  amount     :integer
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  stream_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_tickets_on_stream_id  (stream_id)
#  index_tickets_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (stream_id => streams.id)
#  fk_rails_...  (user_id => users.id)
#
class Ticket < ApplicationRecord
  belongs_to :stream
  belongs_to :user
end
