class Recipe < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :preparation_time, presence: true, numericality: { greater_than: 0 }
  validates :cooking_time, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true
  has_many :recipe_foods, dependent: :destroy
end
