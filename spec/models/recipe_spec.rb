require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before(:each) do
    @user = User.create(name: "Test user", email:"test444@gmail.com", password:"123456", password_confirmation:"123456", confirmation_token: nil, confirmed_at: Time.now)
    @recipe = Recipe.create(name: "Test recipe", preparation_time: 10.2, cooking_time: 20.3, description: "Test description", public: true, user_id: @user.id)
 end
  it "is valid with valid attributes" do
    expect(@recipe).to be_valid
  end

end
