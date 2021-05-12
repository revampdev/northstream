class Product < ApplicationRecord
  belongs_to :stream
  has_rich_text :body
end
