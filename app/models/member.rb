class Member < ApplicationRecord
  has_and_belongs_to_many :groups
  belongs_to :user
  validates :interestRating, presence: true

end
