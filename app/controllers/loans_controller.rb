# encoding: utf-8
class LoansController < ApplicationController
  require 'action_view'
  include ActionView::Helpers::DateHelper
  before_filter :authenticate_user!
  before_filter :get_element, :except => [:finish_loan]
  
  def get_element
    @element = Element.find(params[:element_id])
  end
  
  def index
    #@loaned_elements_by_me: elements that I have loaned to other users.
    @loaned_elements_by_me = current_user.loans
    #@loaned_elements_to_me elements that other users loaned to me.
    @loaned_elements_to_me = Loan.where(:loaned_to_id => current_user)
  end

  def create
    unless @element.loaned
      @loan = @element.loans.build(params[:loan])
      @loan.element = @element
      p "*"*100
      p @loan.user = @element.inventory.user
      respond_to do |format|
        if @loan.save
          if @element.update_attribute(:loaned, true)
            flash[:notice] = "Se ha prestado el elemento."
          else
            flash[:alert] = "El elemento no se pudo prestar."  
          end
        else
          flash[:alert] = "El elemento no se pudo prestar, falta algún atributo para el préstamo?."
        end
        p "*"*100
        p @loan
        format.js
      end  
    else
      flash[:alert] = "El elemento ya ha sido prestado."
    end
  end

  def update
    respond_to do |format|
      if @loan.update_attributes(params[:loan])
        flash[:notice] = "El préstamo se ha actualizado."
      else
        flash[:alert] = "El préstamo no pudo ser actualizado."
      end
      format.js
    end
  end

  def finish_loan
    @loan = Loan.find(params[:id])
    @element = @loan.element
    if @element.loaned
      if @loan.update_attributes(finished: true, end_date: Time.now)
        if @element.update_attribute(:loaned, false)
          flash[:notice] = "El préstamo ha finalizado, la duración del préstamo fue apróximadamente #{distance_of_time_in_words(@loan.start_date, @loan.end_date)}."
          p $path
          if $path == "inventories/:id/elements/:id"
            redirect_to inventory_element_path(@element.inventory, @element)
          else
            redirect_to inventory_path(@element.inventory)  
          end
        else
          flash[:alert] = "No se pudo actualizar el elemento."  
          if $path == "inventories/:id/elements/:id"
            redirect_to inventory_element_path(@element.inventory, @element)
          else
            redirect_to inventory_path(@element.inventory)  
          end
        end
      else
        flash[:alert] = "No se pudo finalizar el préstamo del elemento."
        if $path == "inventories/:id/elements/:id"
          redirect_to inventory_element_path(@element.inventory, @element)
        else
          redirect_to inventory_path(@element.inventory)  
        end
      end
    else
      flash[:alert] = "No se pudo finalizar el préstamo del elemento."
      if $path == "inventories/:id/elements/:id"
        redirect_to inventory_element_path(@element.inventory, @element)
      else
        redirect_to inventory_path(@element.inventory)  
      end
    end
  end
end