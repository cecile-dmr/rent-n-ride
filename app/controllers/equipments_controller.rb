class EquipmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_equipment, only: %i[show edit update destroy]
  before_action :check_user_permission, only: %i[edit update destroy]

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
    @equipment = current_user.equipments.new(equipment_params)
    if @equipment.save
      redirect_to @equipment, notice: "Équipement ajouté avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @equipment.update(equipment_params)
      redirect_to @equipment, notice: "L'équipement a été mis à jour avec succès."
    else
      render :edit
    end
  end

  def destroy
    @equipment = Equipment.find(params[:id])
    @equipment.destroy
    redirect_to root_path, notice: "L'équipement a été supprimé avec succès."
  end

  private

  def set_equipment
    @equipment = Equipment.find(params[:id])
  end

  def check_user_permission
    unless @equipment.user == current_user
      redirect_to equipments_path, alert: "Vous n'avez pas la permission de modifier ou supprimer cet équipement."
    end
  end

  def equipment_params
    params.require(:equipment).permit(:name, :description, :category, :price, photos: [])
  end
end
