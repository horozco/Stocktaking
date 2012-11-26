class ElementsController < ApplicationController
  def create
	  	@inventory = Inventory.find(params[:inventory_id])
	  	@element = @inventory.elements.build(params[:element])
	  	if @element.save
		  respond_to do |format|
	        format.html {redirect_to inventory_path(@inventory), :notice => "Your element was created :)"}
	        format.js
	      end  			
	  	else
	  	  respond_to do |format|
		    format.html {redirect_to inventory_path(@inventory), :alert => "Your element couldn't be submitted. :("}
		    format.js
	      end
	  	end
  end

  def destroy
  		@inventory = Inventory.find(params[:inventory_id])
	  	@element = Element.find(params[:id])	
	  	if @element.destroy
		  respond_to do |format|
	        format.html {redirect_to inventory_path(@inventory), :notice => "Your element was destroy susscefully :)"}
	        format.js
	      end  			
	  	else
	  	  respond_to do |format|
		    format.html {redirect_to inventory_path(@inventory), :alert => "Your element couldn't be destroy. :("}
		    format.js
	      end
	  	end
  end

  def edit
  		@inventory = Inventory.find(params[:inventory_id])
	  	@element = Element.find(params[:id])
  end

  def update
  	  	@inventory = Inventory.find(params[:inventory_id])
	  	@element = Element.find(params[:id])
	  	if @element.update_attributes(params[:element])
      		redirect_to @inventory, notice: "Element was updated" 
    	else
      		flash[:alert] = "Element wasn't updated :("
      		render action: "edit"
    	end		
  end
  
end
