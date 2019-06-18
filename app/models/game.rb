class Game < ApplicationRecord
    belongs_to :user
    belongs_to :genre
    has_one_attached :avatar
end
