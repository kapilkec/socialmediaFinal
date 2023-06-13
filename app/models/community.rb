class Community < ApplicationRecord
  has_many :groups,dependent: :destroy

end
