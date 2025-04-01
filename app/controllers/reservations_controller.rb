class ReservationsController < ApplicationController
  before_action :set_equipment

  def create
    @reservation = @equipment.reservations.new(reservation_params)
    @reservation.user = current_user

    if @reservation.save
      redirect_to @equipment, notice: "Réservation effectuée avec succès !"
    else
      render "equipments/show", status: :unprocessable_entity
    end
  end

  private

  def set_equipment
    @equipment = Equipment.find(params[:equipment_id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date)
  end
end
