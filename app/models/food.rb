class Food < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, uniqueness: { scope: :user_id }
  has_many :recipe_foods, dependent: :destroy
end
