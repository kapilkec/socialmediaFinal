class Post < ApplicationRecord
  validates :title, presence: true
  has_many :comments, dependent: :destroy
  has_many :likes ,as: :likeable ,dependent: :destroy
  validates :description,presence: true,  length: { minimum: 10 }
  has_many_attached :images ,dependent: :destroy
  before_create :randomize_id
  belongs_to :user

  private
  def randomize_id

      self.id = SecureRandom.random_number(1_000_000_000)

  end
end
