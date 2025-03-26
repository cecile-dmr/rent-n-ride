class Equipment < ApplicationRecord
  belongs_to :user
  has_many :reservations
  has_many :users, through: :reservations
  has_many_attached :photos

  validates :name, presence: true
  validates :category, presence: true
  validates :price, numericality: { greater_than: 0 }
  geocoded_by :address
  after_validation :geocode
end
