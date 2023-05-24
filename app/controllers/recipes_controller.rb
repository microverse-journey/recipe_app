class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:public_recipes]
  load_and_authorize_resource except: [:public_recipes]
  def index
    @recipes = current_user.recipes.order(:name)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = current_user.recipes.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      redirect_to recipes_path
    else
      render :new
    end
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])
    @recipe&.destroy
    redirect_to recipes_path
  end

  def public_recipes
    @recipes = Recipe.where(public: true).includes(:user, recipe_foods: :food).order(created_at: :desc)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :preparation_time, :cooking_time, :public)
  end
end
