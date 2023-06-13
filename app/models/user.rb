class User < ApplicationRecord
  has_many :likes,dependent: :destroy
  has_one :story,dependent: :destroy
  has_many :groups,dependent: :destroy
  has_many :communitys , :through => :groups,dependent: :destroy
end
