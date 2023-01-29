# frozen_string_literal: true

class QuotesController < ApplicationController
  before_action :set_quote, only: %i[show edit update destroy]
  # before_action { sleep 1 }

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
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @quote.update(quote_params)
      redirect_to quotes_path, notice: 'Quote was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @quote.destroy

    # Este render es equivalente a crear un archivo llamado "views/quotes/destroy.turbo_stream.erb",
    # cuyo contenido podría ser:
    # <%= turbo_stream.remove @quote %>
    # o bien:
    # <turbo-stream action='remove' target='<%= dom_id(@quote) %>'> </turbo-stream>
    render turbo_stream: [
      turbo_stream.remove(@quote)
    ]
  end

  private

  def set_quote
    @quote = Quote.find(params[:id])
  end

  def quote_params
    params.require(:quote).permit(:name)
  end
end
