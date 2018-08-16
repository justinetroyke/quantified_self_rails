class Api::V1::MealsController < ApplicationController
  def index
    render json: Meal.all
  end

  def show
    begin
      meal = Meal.find(params[:meal_id])
      render json: meal
    rescue
      render json: { error: "Meal not found" }, status: 404
    end
  end
end
