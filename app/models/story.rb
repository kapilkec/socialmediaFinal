class Story < ApplicationRecord
  belongs_to :user
  has_one_attached :image ,dependent: :destroy
  before_create :set_expiration_time
  validates :note, presence: true, length: { minimum: 2, maximum: 20}
  scope :not_expired, -> { where('expiration_time > ?', Time.now) }

  private

  def set_expiration_time
    self.expiration_time = Time.now + 1.day # Set the expiration time (e.g., 1 day from the current time)
  end
end
