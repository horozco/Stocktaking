class LoansController < ApplicationController

  before_filter :authenticate_user!, :get_element

  def get_element
    @element = Element.find(params[:inventory_id])
  end

  def create
    unless @element.loaned
      @loan = @element.elements.build(params[:loan])
      respond_to do |format|
        if @loan.save
          if @element.update_attribute(:loaned, true)
            flash[:notice] = "Se ha prestado el elemento."
          else
            flash[:alert] = "El elemento no se pudo prestar."  
          end
        else
          flash[:alert] = "El elemento no se pudo prestar."
        end
        format.js
      end  
    else
      flash[:alert] = "El elemento ya ha sido prestado."
    end
  end

  def destroy
    if @element.loaned
      if @element.update_attribute(:loaned, false)
        flash[:notice] = "El prestamo ha finalizado."
        redirect_to inventory_element_path(@element)
      else
        flash[:alert] = "No se pudo actualizar el elemento."
      end
    else
      flash[:alert] = "El elemento no ha sido prestado."
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
