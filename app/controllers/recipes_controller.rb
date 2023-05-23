class RecipesController < ApplicationController
  before_action :authenticate_user!
  def index
    @recipes = Recipe.all
  end
end
