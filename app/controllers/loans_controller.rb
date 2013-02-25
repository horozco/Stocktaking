class LoansController < ApplicationController

  before_filter :authenticate_user!, :get_element

  def get_element
    @element = Element.find(params[:inventory_id])
  end

  def create
    @loan = @element.elements.build(params[:loan])
    respond_to do |format|
      if @loan.save
        flash[:notice] = "Se ha prestado el elemento."
      else
        flash[:alert] = "El elemento no se pudo prestar."
      end
      format.js
    end
  end

  def destroy
    if @loan.destroy
      flash[:notice] = "El prestamo ha finalizado."
      redirect_to inventory_element_path(@element)
    else
      flash[:alert] = "No se pudo finalizar el préstamo."
      redirect_to inventory_element_path(@element)
    end
  end

  def update
    respond_to do |format|
      if @loan.update_attributes(params[:loan])
        flash[:notice] = "El prestamo se ha actualizado."
      else
        flash[:alert] = "El préstamo no pudo ser actualizado."
      end
      format.js
    end
  end
end
