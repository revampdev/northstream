# == Schema Information
#
# Table name: streams
#
#  id               :bigint           not null, primary key
#  free_stream      :boolean
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
class Stream < ApplicationRecord
  extend FriendlyId
  acts_as_tenant :account
  belongs_to :account

  friendly_id :name, use: :slugged

  has_many :tickets, dependent: :destroy
  has_many :users, through: :tickets
  has_many :products, dependent: :destroy
  has_rich_text :body
  has_one_attached :stream_image
  validates :name, presence: true
  validates :price, presence: true
  validates :stream_date, presence: true
  validates :account, presence: true
end
