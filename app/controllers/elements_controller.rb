#encoding: utf-8
class ElementsController < ApplicationController

  before_filter :authenticate_user!, :get_inventory

  def get_inventory
    @inventory = Inventory.find(params[:inventory_id])
  end

  def create
    unless @inventory.finished?
    	@element = @inventory.elements.build(params[:element])
      respond_to do |format|
        if @element.save
          flash[:notice] = "Se ha creado el elemento."
        else
          flash[:alert] = "El elemento no se pudo crear."
        end
        format.js
      end
    else
      flash[:alert] = "El inventario ya se ha finalizado, no se puede crear ningún elemento."
    end
  end

  def destroy
  	unless @inventory.finished?
      @element = Element.find(params[:id])
    	if @element.destroy
        flash[:notice] = "El elemento ha sido destruido."
        redirect_to inventory_path(@inventory)
    	else
  	    flash[:alert] = "No se pudo destruir el elemento."
  	    redirect_to inventory_path(@inventory)
    	end
    else
      flash[:alert] = "El inventario ya se ha finalizado, no se puede eliminar ningún elemento."
      redirect_to @inventory
    end
  end

  def update
    unless @inventory.finished?
    	@element = Element.find(params[:id])
    	respond_to do |format|
        if @element.update_attributes(params[:element])
          flash[:notice] = "El elemento se ha actualizado."
        else
          flash[:alert] = "El elemento no pudo ser actualizado."
        end
        format.js
      end
    else
      flash[:alert] = "El inventario ya se ha finalizado, no se puede editar ningún elemento."
    end
  end

  def show
  	@element = Element.find(params[:id])
    $path = request.fullpath
  end
end
