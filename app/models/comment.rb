class Comment < ApplicationRecord
  belongs_to :post
  has_many :likes ,as: :likeable
end
