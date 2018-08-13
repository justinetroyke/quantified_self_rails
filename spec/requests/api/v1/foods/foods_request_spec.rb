require 'rails_helper'

describe "Foods API" do
  it "sends a list of foods" do
    create_list(:food, 3)

    get '/api/v1/foods'

    expect(response).to be_successful

    foods = JSON.parse(response.body)

    expect(foods.count).to eq(3)
  end

  it "sends a specific food" do
    id = create(:food).id

    get "/api/v1/foods/#{id}"

    food = JSON.parse(response.body)

    expect(response).to be_successful
    expect(food["id"]).to eq(id)
  end

  it "returns 404 if a specific food is not found" do
    get "/api/v1/foods/10"

    expect(status).to eq(404)
  end
end
