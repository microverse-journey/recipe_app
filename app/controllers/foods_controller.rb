class FoodsController < ApplicationController
  load_and_authorize_resource
  def index
    @foods = current_user.foods
  end

  def new
    @food = Food.new
  end

  def create
    if current_user.foods.create!(food_params)
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

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :quantity, :price)
  end
end
