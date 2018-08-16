require 'rails_helper'

describe 'Meals API' do
  it 'returns all meals and their associated foods' do
    meals_index = create_list(:meal, 3)
    one = meals_index.first
    one.foods.create!(name: 'Kiwi', calories: '123')
    one.foods.create!(name: 'Almonds', calories: '321')
    one.foods.create!(name: 'Coconut', calories: '58')

    get '/api/v1/meals'

    expect(response).to be_success

    meals = JSON.parse(response.body)

    expect(meals.count).to eq(3)
    expect(meals.first["foods"].count).to eq(3)
    expect(meals.last["foods"].count).to eq(0)
  end

  it 'shows the foods of a specific meal id' do
    get "/api/v1/meals/#{22}/foods"

    expect(status).to eq(404)

    meal = create(:meal)
    meal.foods.create!(name: 'Kiwi', calories: '123')
    meal.foods.create!(name: 'Almonds', calories: '321')
    meal.foods.create!(name: 'Coconut', calories: '58')

    get "/api/v1/meals/#{meal.id}/foods"

    expect(response).to be_success

    foods = JSON.parse(response.body)
    expect(foods.count).to eq(3)
  end
end
