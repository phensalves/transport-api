class Facility < ApplicationRecord
  belongs_to :customer, optional: true

  validates :city, presence: true
  validates :state, presence: { message: "State is required!" }
  validates :cep, presence: { message: "CEP is required!" }
  validates :country, presence: { message: "Country is required!" }
  validates :description, presence: { message: "Description is required!" }
  validates :number, presence: { message: "Number is required!" }
end
