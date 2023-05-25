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
    @shopping_list = current_user.foods.select('foods.name', 'SUM(recipe_foods.quantity) AS total_quantity','foods.quantity AS food_quantity', 'foods.price')
      .joins(recipe_foods: :recipe)
      .group('foods.name, foods.quantity, foods.price')
      .having('SUM(recipe_foods.quantity) > foods.quantity')

    # @shopping_list = current_user.foods

    @total_food_items = @shopping_list.length

    @total = @shopping_list.sum { |food| (food.total_quantity - food.food_quantity) * food.price }
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :quantity, :price)
  end
end
