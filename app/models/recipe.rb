class Recipe < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :materials, dependent: :destroy
  has_many :steps, dependent: :destroy
  has_many :recipe_tags, dependent: :destroy
  has_many :impression, dependent: :destroy
  
  attachment :image
end
