class WeightMeasurement < ApplicationRecord
  belongs_to :user

  validates :weight, numericality: { greater_than: 0.0 }
  validates :day, numericality: { greater_than: 0, only_integer: true }, uniqueness: {scope: :user}
end
