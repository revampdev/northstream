require "administrate/base_dashboard"

class StreamDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    account: Field::BelongsTo,
    tickets: Field::HasMany,
    users: Field::HasMany,
    body: Field::RichText,
    stream_image_attachment: Field::HasOne,
    stream_image_blob: Field::HasOne,
    id: Field::Number,
    name: Field::String,
    price: Field::Number,
    slug: Field::String,
    status: Field::String,
    stream_date: Field::DateTime,
    stream_key: Field::String,
    stream_rtmp_link: Field::String,
    live_stream_id: Field::String,
    playback_id: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  account
  tickets
  users
  body
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  account
  tickets
  users
  body
  stream_image_attachment
  stream_image_blob
  id
  name
  price
  slug
  status
  stream_date
  stream_key
  stream_rtmp_link
  live_stream_id
  playback_id
  created_at
  updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  account
  tickets
  users
  body
  stream_image_attachment
  stream_image_blob
  name
  price
  slug
  status
  stream_date
  stream_key
  stream_rtmp_link
  live_stream_id
  playback_id
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how streams are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(stream)
  #   "Stream ##{stream.id}"
  # end
end
