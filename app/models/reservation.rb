class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :equipment

  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :start_date_before_end_date

  private

  def start_date_before_end_date
    errors.add(:start_date, "must be before the end date") if start_date && end_date && start_date > end_date
  end
end
