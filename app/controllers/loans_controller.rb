# encoding: utf-8
class LoansController < ApplicationController
  require 'action_view'
  include ActionView::Helpers::DateHelper
  before_filter :authenticate_user!
  before_filter :get_element, :except => [:finish_loan, :loaned_elements_to_me, :loaned_elements_by_me]

  def get_element
    @element = Element.find(params[:element_id])
  end

  def loaned_elements_by_me
    #@loaned_elements_by_me: elements that I have been loaned to other users.
    @loans = current_user.loans.page(params[:page]).per(10).order(:finished)
  end

  def loaned_elements_to_me
    #@loaned_elements_to_me elements that other users loaned to me.
    @loans = Loan.where(:loaned_to_id => current_user).page(params[:page]).per(10).order(:finished)
  end

  def create
    unless @element.loaned
      @loan = @element.loans.build(params[:loan])
      @loan.element = @element
      @loan.user = @element.inventory.user
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
        format.js
      end
    else
      flash[:alert] = "El elemento ya ha sido prestado."
    end
  end

  def update
    @loan = Loan.find(params[:id])
    unless @loan.finished
      respond_to do |format|
        if @loan.update_attributes(params[:loan])
          flash[:notice] = "El préstamo se ha actualizado."
        else
          flash[:alert] = "El préstamo no pudo ser actualizado."
        end
        format.js
      end
    else
      flash[:alert] = "No se puede actualizar un préstamo que ya ha finalizado."
    end
  end

  def finish_loan
    @loan = Loan.find(params[:id])
    @element = @loan.element
    if @element.loaned
      if @loan.update_attributes(finished: true, end_date: Time.now)
        if @element.update_attribute(:loaned, false)
          flash[:notice] = "El préstamo ha finalizado, la duración del préstamo fue de #{distance_of_time_in_words(@loan.start_date, @loan.end_date)}."
          redirect_to params[:return]
        else
          flash[:alert] = "No se pudo actualizar el elemento."
          redirect_to params[:return]
        end
      else
        flash[:alert] = "No se pudo finalizar el préstamo del elemento."
        redirect_to params[:return]
      end
    else
      flash[:alert] = "No se pudo finalizar el préstamo del elemento."
      redirect_to params[:return]
    end
  end
end