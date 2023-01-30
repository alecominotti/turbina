# frozen_string_literal: true

class QuotesController < ApplicationController
  before_action :set_quote, only: %i[show edit update destroy]
  # before_action { sleep 1 }

  # NOTA:
  # ¿Por qué los métodos create, update y destroy tienen dos 'format' adentro de un 'respond_to'?
  # De esta manera, dichos métodos saben responder con acciones de Turbo y con respuestas HTML convencionales
  # en caso de que Turbo esté desactivado.

  # Esto se puede probar comentando la línea 1 del archivo "app/javascript/application.js" la cual importa Turbo Rails.
  # Al estar comentada, nuestra app va a funcionar sin Turbo y estos métodos van a responder con el formato HTML.
  # Todo sigue funcionando normalmente, con o sin Turbo :)

  def index
    @quotes = Quote.all.order(created_at: :desc)
  end

  def show; end

  def new
    @quote = Quote.new
  end

  def create
    @quote = Quote.new(quote_params)

    if @quote.save
      respond_to do |format|
        format.html { redirect_to quotes_path, notice: 'Quote was successfully created.' }
        format.turbo_stream { flash.now[:notice] = 'Quote was successfully created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @quote.update(quote_params)
      respond_to do |format|
        format.html { redirect_to quotes_path, notice: 'Quote was successfully updated.' }
        format.turbo_stream { flash.now[:notice] = 'Quote was successfully updated.' }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @quote.destroy

    respond_to do |format|
      format.html { redirect_to quotes_path, notice: 'Quote was successfully destroyed.' }
      format.turbo_stream { flash.now[:notice] = 'Quote was successfully destroyed.' }
    end

    # Una solución equivalente de este format.turbo_stream es:
    # ELIMINAR el archivo "views/quotes/destroy.turbo_stream.erb"
    # y reemplazar la linea 57 por el siguiente código:

    # format.turbo_stream do
    #   flash.now[:notice] = 'Quote was successfully destroyed.'
    #   render turbo_stream: [
    #     turbo_stream.remove(@quote),
    #     turbo_stream.prepend('flash', partial: 'layouts/flash')
    #   ]
    # end
  end

  private

  def set_quote
    @quote = Quote.find(params[:id])
  end

  def quote_params
    params.require(:quote).permit(:name)
  end
end
