class EquipmentsController < ApplicationController

  def index
    @equipments = Equipment.all
  end

  def show
    @equipment = Equipment.find(params[:id])
  end

  def new
    @equipment = Equipment.new
  end

  def create
    @equipment = Equipment.new(equipment_params)
    if @equipment.save
      redirect_to @equipment, notice: "Équipement ajouté avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

private

  def equipment_params
    params.require(:equipment).permit(:name, :description, :price, photos: [])
  end
end
