class User < ApplicationRecord
  has_many :likes
  has_one :story
end
