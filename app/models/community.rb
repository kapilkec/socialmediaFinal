class Community < ApplicationRecord
  has_many :groups,dependent: :destroy
  validates :name, presence: true,length: { minimum: 2, maximum: 20}
  validates :vision, presence: true,length: { minimum: 2, maximum: 20}
  validates :category, presence: true,length: { minimum: 2, maximum: 20}
end
