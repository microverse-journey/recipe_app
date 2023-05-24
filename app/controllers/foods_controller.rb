class FoodsController < ApplicationController
  load_and_authorize_resource
  def index
    @foods = current_user.foods
  end

  def new
    @food = Food.new
  end

  def create
    @food = current_user.foods.new(food_params)
    if @food.save
      redirect_to foods_path, notice: 'Food successfully created'
    else
      render :new, notice: 'Failed to add food'
    end
  end

  def destroy
    @food = current_user.foods.find(params[:id])
    if @food.destroy
      redirect_to foods_path, notice: 'Food deleted successfuly'
    else
      redirect_to foods_path, alert: 'Oops something went wrong'
    end
  end

  def general_shopping_list
    @shopping_list = Food.select('foods.name AS food_name, SUM(recipe_foods.quantity) AS total_quantity, foods.quantity AS food_quantity')
    .left_joins(:recipe_foods)
    .left_joins(:recipes)
    .where('foods.user_id = ?', current_user.id)
    .group('recipe_foods.food_id')
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :quantity, :price)
  end
end
