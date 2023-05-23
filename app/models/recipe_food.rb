class Recipe_food < ApplicationRecord
  belongs_to :recipe
  belongs_to :food
end
