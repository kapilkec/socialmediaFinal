class Group < ApplicationRecord
  belongs_to :user
  belongs_to :community
  has_and_belongs_to_many :members, dependent: :destroy
  validates :name,presence: true,  length: { minimum: 3 }
    validates :bio , presence: true
end
