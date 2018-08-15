class CreateFoodMeals < ActiveRecord::Migration[5.2]
  def change
    create_table :food_meals do |t|
      t.references :food, foreign_key: true
      t.references :meal, foreign_key: true
    end
  end
end
