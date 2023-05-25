class Food < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, uniqueness: { scope: :user_id }
  has_many :recipe_foods, dependent: :destroy

  def missing_foods
    select('foods.name', 'SUM(recipe_foods.quantity) AS total_quantity',
           'foods.quantity AS food_quantity', 'foods.price')
      .joins(recipe_foods: :recipe)
      .where(user_id: user.id)
      .group('foods.name, foods.quantity, foods.price')
      .having('SUM(recipe_foods.quantity) > foods.quantity')
  end
end
