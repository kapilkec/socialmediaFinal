class Post < ApplicationRecord
  validates :title, presence: true
  has_many :comments
  has_many :likes ,as: :likeable
 validates :description,presence: true,  length: { minimum: 10 }
  has_many_attached :images
  before_create :randomize_id

  private
  def randomize_id

      self.id = SecureRandom.random_number(1_000_000_000)

  end
end
