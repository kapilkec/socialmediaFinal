class Post < ApplicationRecord
  paginates_per 3
  validates :title, presence: true,length: { minimum: 2, maximum: 20}
  has_many :comments, dependent: :destroy
  has_many :likes ,as: :likeable ,dependent: :destroy
  validates :description,presence: true,  length: { minimum: 10, maximum: 50}
  has_many_attached :images ,dependent: :destroy
  before_create :randomize_id
  belongs_to :user

  scope :likes_greater_than_one, -> {
    joins("LEFT JOIN (SELECT likeable_id, COUNT(id) AS count_likes FROM likes WHERE likeable_type = 'Post' GROUP BY likeable_id) subquery ON subquery.likeable_id = posts.id")
    .select('posts.*, subquery.count_likes')
    .where('subquery.count_likes > ?', 1)
  }

  scope :with_zero_comments, -> { left_outer_joins(:comments).where(comments: { id: nil }) }



  def post_owner_name
    self.user.name
  end
  private
  def randomize_id

      self.id = SecureRandom.random_number(1_000_000_000)

  end
end
