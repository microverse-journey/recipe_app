class Recipe < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  has_many :recipe_foods, dependent: :destroy
end