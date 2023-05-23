class RecipeFoodsController < ApplicationController
  def new
    @recipe = current_user.recipes.find(params[:id])
  end

  def create
     @recipe =current_user.recipes.find(params[:id])
      @recipe_food = RecipeFood.new(recipe_food_params, recipe_id: @recipe.id)
    if @recipe_food.save
      redirect_to request.referrer
    else
      render :new
    end
  end

  private
  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
