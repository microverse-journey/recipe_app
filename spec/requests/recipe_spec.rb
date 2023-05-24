require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  before(:each) do
    @user = User.create(name: "Test user", email:"test444@gmail.com", password:"123456", password_confirmation:"123456", confirmation_token: nil, confirmed_at: Time.now)
    @recipe = Recipe.create(name: "Test recipe", preparation_time: 10.2, cooking_time: 20.3, description: "Test description", public: true, user_id: @user.id)
    @recipeTwo = Recipe.create(name: "Test recipe Two", preparation_time: 10.2, cooking_time: 20.3, description: "Test description two", public: true, user_id: @user.id)
  end

  describe "GET /public recipe" do
    it "returns http success" do
       get public_recipes_path
       expect(response).to have_http_status(200)
    end
   it "renders the index template" do
      get public_recipes_path
      expect(response).to render_template("index").or(render_template("recipes/public_recipes"))
   end
   it "displays the recipe name" do
      get public_recipes_path
      expect(response.body).to include(@user.recipes.first.name)
   end
  end
end
