class Group < ApplicationRecord
  belongs_to :user
  belongs_to :community
  has_and_belongs_to_many :members, dependent: :destroy
  validates :name, presence: true,  length: { minimum: 2,maximum: 20}
  validates :bio, presence: true,  length: { minimum: 2,maximum: 20}

  scope :group_with_community_one, -> {
   where('community_id == ?', 1)
  }

end
