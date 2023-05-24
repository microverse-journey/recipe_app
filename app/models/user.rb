class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :recipes, dependent: :destroy
  validates :name, presence: true
  has_many :foods, dependent: :destroy

  def shopping_lists
    recipes = self.recipes
    general_food_list = []
    recipes.each do |recipe|
      recipe.recipe_foods.each do |recipe_food|
        general_food_list << recipe_food.food
      end
    end
    
    user_food_list = self.foods
    
    missing_food_list = general_food_list - user_food_list
    total_food_items = missing_food_list.size
    total_price = missing_food_list.sum(&:price)
    
    {
      missing_food_list: missing_food_list,
      total_food_items: total_food_items,
      total_price: total_price
    }

  end

end
