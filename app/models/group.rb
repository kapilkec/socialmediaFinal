class Group < ApplicationRecord
  belongs_to :user
  belongs_to :community
  has_and_belongs_to_many :members, dependent: :destroy

end
