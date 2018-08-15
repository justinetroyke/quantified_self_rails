class Meal < ApplicationRecord
  validates_presence_of :name

  has_many :food_meals
  has_many :foods, through: :food_meals
end
