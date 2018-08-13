require 'rails_helper'

describe "Foods API" do
  it "sends a list of foods" do
    create_list(:food, 3)

    get '/api/v1/foods'

    expect(response).to be_successful

    foods = JSON.parse(response.body)

    expect(foods.count).to eq(3)
  end
end
