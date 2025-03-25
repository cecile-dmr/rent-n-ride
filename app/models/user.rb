class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :equipments
  has_many :reservations
  has_many :rented_equipments, through: :reservations, source: :equipment

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
