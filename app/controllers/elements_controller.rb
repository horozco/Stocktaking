class ElementsController < ApplicationController
  def create
  	@inventory = Inventory.find(params[:inventory_id])
  	@element = @inventory.elements.build(params[:element])
    respond_to do |format|
      if @element.save
        flash[:notice] = "Se ha creado el elemento."
      else
        flash[:alert] = "El elemento no se pudo crear."
      end
      format.js
    end
  end

  def destroy
		@inventory = Inventory.find(params[:inventory_id])
  	@element = Element.find(params[:id])
  	if @element.destroy
      flash[:notice] = "El elemento ha sido destruido."
      redirect_to inventory_path(@inventory)
  	else
	    flash[:alert] = "No se pudo destruir el elemento."
	    redirect_to inventory_path(@inventory)
  	end
  end

  def update
	  @inventory = Inventory.find(params[:inventory_id])
  	@element = Element.find(params[:id])
  	respond_to do |format|
      if @element.update_attributes(params[:element])
        flash[:notice] = "El elemento se ha actualizado."
      else
        flash[:alert] = "El elemento no pudo ser actualizado."
      end
      format.js
    end
  end

  def show
  	@inventory = Inventory.find(params[:inventory_id])
  	@element = Element.find(params[:id])
    $path = request.fullpath
  end
end
