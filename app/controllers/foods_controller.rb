class FoodsController < ApplicationController
    def index
    end

    def new
        @food = Food.new
    end

    def create
        render :new unless current_user.foods.create(food_params)
        
        redirect_to user_foods_path(current_user), notice: "Food successfully created"
    end

    private
    def food_params
        params.require(:food).permit(:name, :measurement_unit, :quantity, :price)
    end
end
