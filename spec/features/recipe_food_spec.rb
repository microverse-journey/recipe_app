require 'rails_helper'

RSpec.describe 'RecipeFoods', type: :feature do
  before(:each) do
    @user = User.create(name: 'Test user', email: 'test444@gmail.com', password: '123456', password_confirmation: '123456',
                        confirmation_token: nil, confirmed_at: Time.now)
    @recipe = Recipe.create(name: 'Test recipe', preparation_time: 10.2, cooking_time: 20.3,
                            description: 'Test description', public: true, user_id: @user.id)
    @recipe_two = Recipe.create(name: 'Test recipe Two', preparation_time: 10.2, cooking_time: 20.3,
                                description: 'Test description two', public: true, user_id: @user.id)
    @food = Food.create(name: 'Test food', price: 12.2, quantity: 4, measurement_unit: 'pce', user_id: @user.id)
    @food_two = Food.create(name: 'Test food Two', price: 12.2, quantity: 4, measurement_unit: 'pce', user_id: @user.id)
    @recipe_food = RecipeFood.create(quantity: 10, recipe_id: @recipe.id, food_id: @food.id)
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
  end
  describe ' recipe_food new page' do
    scenario 'should display add ingredient form' do
      visit new_recipe_recipe_food_path(@recipe)
      expect(page).to have_content('Add ingredient')
    end
  end
  scenario 'should display add ingredient form' do
    visit new_recipe_recipe_food_path(@recipe)
    expect(page).to have_content('Quantity')
    expect(page).to have_content('Food')
    expect(page).to have_content('description')
  end
  scenario 'shoudld have a button to add ingredient' do
    visit new_recipe_recipe_food_path(@recipe)
    expect(page).to have_button('Add ingredient')
  end
  scenario 'should have a button to remove' do
    visit new_recipe_recipe_food_path(@recipe)
    expect(page).to have_button('Remove')
  end
  scenario 'should have a button to modify' do
    visit new_recipe_recipe_food_path(@recipe)
    expect(page).to have_button('Modify')
  end
  scenario 'When i click on add ingredient button it should add ingredient to recipe' do
    visit new_recipe_recipe_food_path(@recipe)
    fill_in 'Quantity', with: 10
    select 'Test food', from: 'Food'
    click_button 'Add ingredient'
    expect(page).to have_content('Test food')
  end
  scenario 'When i click on remove button it should remove ingredient from recipe' do
    visit new_recipe_recipe_food_path(@recipe)
    fill_in 'Quantity', with: 10
    select 'Test food', from: 'Food'
    click_button 'Add ingredient'
    expect(page).to have_content('Test food')
    find('a', text: 'Remove', match: :first).click
    expect(page).to have_no_content(@recipe_food.id)
  end
end
