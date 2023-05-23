class Food < ApplicationRecord
  belongs_to :user
  validates :name, uniqueness: true
  has_many :recipe_foods, dependent: :destroy
end
