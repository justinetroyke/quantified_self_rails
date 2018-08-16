require 'rails_helper'

describe 'FoodMeal API' do
  describe 'POST /api/v1/meals/:meal_id/foods/:id' do
    it 'should add the food with :id to the meal with :meal_id' do
      meal = create(:meal)
      meal.foods.create!(name: 'Kiwi', calories: '123')
      meal.foods.create!(name: 'Almonds', calories: '321')
      meal.foods.create!(name: 'Coconut', calories: '58')

      post "/api/v1/meals/#{meal.id}/foods/#{meal.foods.first.id}"

      expect(Meal.find(meal.id).foods.first).to eq(meal.foods.first)
    end

    it 'should return a 404 with error if the meal cannot be found' do
      post "/api/v1/meals/#{2}/foods/#{3}"

      expect(status).to eq(404)
      expect(response.body).to eq({ error: 'Meal not found' }.to_json)
    end

    it 'returns a 404 with error if the food cannot be found' do
      meal = create(:meal)

      post "/api/v1/meals/#{meal.id}/foods/#{1}"

      expect(status).to eq(404)
      expect(response.body).to eq({ error: 'Food not found' }.to_json)
    end

    it 'should return a 201 and a success message if successful' do
      meal = create(:meal)
      meal.foods.create!(name: 'Kiwi', calories: '123')
      meal.foods.create!(name: 'Almonds', calories: '321')
      meal.foods.create!(name: 'Coconut', calories: '58')

      post "/api/v1/meals/#{meal.id}/foods/#{meal.foods.first.id}"

      expect(status).to eq(201)
      expect(response.body).to eq({ message: "Successfully added #{meal.foods.first.name} to #{meal.name}" }.to_json)
    end
  end

  describe 'DELETE /api/v1/meals/:meal_id/foods/:id' do
    it 'should delete the specific food by id from the specific meal the meal id' do
      meal = create(:meal)
      meal.foods.create!(name: 'Kiwi', calories: '123')

      delete "/api/v1/meals/#{meal.id}/foods/#{meal.foods.first.id}"

      expect(response).to be_successful
      expect(Meal.find(meal.id).foods).to eq([])
    end

    it 'should delete the FoodMeal associated with the meal and food' do
      meal = create(:meal)
      food = create(:food)
      mf = FoodMeal.create!(meal: meal, food: food)

      delete "/api/v1/meals/#{meal.id}/foods/#{meal.foods.first.id}"

      expect(response).to be_successful
      expect{ FoodMeal.find(mf.id) }.to raise_exception(ActiveRecord::RecordNotFound)
    end

    it 'should return a 404 with error message if the meal does not exist' do
      meal = create(:meal)
      food = create(:food)
      food_meal = FoodMeal.create!(meal: meal, food: food)

      delete "/api/v1/meals/#{meal.id + 1}/foods/#{food.id}"

      expect(response).to have_http_status(404)
      expect(response.body).to eq({ error: 'Meal not found' }.to_json)
    end

    it 'should return a 404 with error message if the food does not exist' do
      meal = create(:meal)
      food = create(:food)
      food_meal = FoodMeal.create!(meal: meal, food: food)

      delete "/api/v1/meals/#{meal.id}/foods/#{food.id + 1}"

      expect(response).to have_http_status(404)
      expect(response.body).to eq({ error: 'Food not found' }.to_json)
    end

    it 'should return a success message if successful' do
      meal = create(:meal)
      food = create(:food)
      food_meal = FoodMeal.create!(meal: meal, food: food)

      delete "/api/v1/meals/#{meal.id}/foods/#{food.id}"

      expect(response).to be_successful
      expect(response.body).to eq({ message: "Successfully removed #{food.name} from #{meal.name}" }.to_json)
    end
  end
end
