class Api::V1::FoodMealsController < ApplicationController

  def create
    begin
      meal = Meal.find(params[:meal_id])
      food = Food.find(params[:id])
      FoodMeal.create!(meal: meal, food: food)
      render json: { message: "Successfully added #{food.name} to #{meal.name}" }, status: 201
    rescue => error
      if error.to_s.include?('Couldn\'t find Meal')
        render json: { error: 'Meal not found' }, status: 404
      elsif error.to_s.include?('Couldn\'t find Food')
        render json: { error: 'Food not found' }, status: 404
      end
    end
  end

  def destroy
  begin
    food = Food.find(params[:id])
    meal = Meal.find(params[:meal_id])
    meal_food = FoodMeal.find_by(meal: meal, food: food)
    meal_food.destroy
    render json: { message: "Successfully removed #{food.name} from #{meal.name}" }
  rescue => error
      if error.to_s.include?("Couldn't find Meal")
        render json: { error: "Meal not found" }, status: 404
      elsif error.to_s.include?("Couldn't find Food")
        render json: { error: "Food not found" }, status: 404
      end
    end
  end
end
