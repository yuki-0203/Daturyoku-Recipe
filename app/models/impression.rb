class Impression < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  attachment :image

  validates :impression, presence: true, length: { maximum: 50 }
  validates :recipe_id, presence: true
  validates :user_id, presence: true
end
