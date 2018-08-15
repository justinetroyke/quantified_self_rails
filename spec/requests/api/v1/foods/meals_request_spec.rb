require 'rails_helper'

describe 'Meals API' do
  it 'returns all meals and their associated foods' do
    create_list(:meal, 3)

    get '/api/v1/meals'

    expect(response).to be_success

    meals = JSON.parse(response.body)
    expect(meals.count).to eq(3)
  end
end
