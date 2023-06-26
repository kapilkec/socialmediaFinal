class Friend < ApplicationRecord
    has_one :notification
    validates :fromUser, presence: true
    validates :toUser, presence: true
end
