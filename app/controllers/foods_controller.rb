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
    @shopping_list = Food.joins(recipe_foods: :recipe)
    .where(user_id: current_user.id)
    .group('foods.name, foods.quantity, foods.price')
    .having('SUM(recipe_foods.quantity) > foods.quantity')
    .pluck('foods.name', 'SUM(recipe_foods.quantity)', 'foods.quantity', 'foods.price')

    @total_food_items = @shopping_list.length

    @total = @shopping_list.sum { |food| (food[1] - food[2]) * food[3] }

  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :quantity, :price)
  end
end
