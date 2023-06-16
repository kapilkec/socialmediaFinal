class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :likes,dependent: :destroy
  has_one :story,dependent: :destroy
  has_many :groups,dependent: :destroy
  has_many :communitys , :through => :groups,dependent: :destroy
  has_many :posts,dependent: :destroy
  has_many :comments,dependent: :destroy
  
end
