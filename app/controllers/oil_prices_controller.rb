class OilPricesController < ApplicationController
  before_action :set_oil_price, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /oil_prices
  # GET /oil_prices.json
  def index
    @oil_prices = OilPrice.all
  end

  # GET /oil_prices/1
  # GET /oil_prices/1.json
  def show
  end

  # GET /oil_prices/new
  def new
    @oil_price = OilPrice.new
  end

  # GET /oil_prices/1/edit
  def edit
  end

  # POST /oil_prices
  # POST /oil_prices.json
  def create
    @oil_price = OilPrice.new(oil_price_params)

    respond_to do |format|
      if @oil_price.save
        format.html { redirect_to @oil_price, notice: 'Oil price was successfully created.' }
        format.json { render :show, status: :created, location: @oil_price }
      else
        format.html { render :new }
        format.json { render json: @oil_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /oil_prices/1
  # PATCH/PUT /oil_prices/1.json
  def update
    respond_to do |format|
      if @oil_price.update(oil_price_params)
        format.html { redirect_to @oil_price, notice: 'Oil price was successfully updated.' }
        format.json { render :show, status: :ok, location: @oil_price }
      else
        format.html { render :edit }
        format.json { render json: @oil_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /oil_prices/1
  # DELETE /oil_prices/1.json
  def destroy
    @oil_price.destroy
    respond_to do |format|
      format.html { redirect_to oil_prices_url, notice: 'Oil price was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_oil_price
      @oil_price = OilPrice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def oil_price_params
      params.require(:oil_price).permit(:daily_oil_price, :date)
    end
end
