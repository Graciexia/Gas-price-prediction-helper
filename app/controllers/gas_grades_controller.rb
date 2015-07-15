class GasGradesController < ApplicationController
  before_action :set_gas_grade, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /gas_grades
  # GET /gas_grades.json
  def index
    @gas_grades = GasGrade.all
  end

  # GET /gas_grades/1
  # GET /gas_grades/1.json
  def show
  end

  # GET /gas_grades/new
  def new
    @gas_grade = GasGrade.new
  end

  # GET /gas_grades/1/edit
  def edit
  end

  # POST /gas_grades
  # POST /gas_grades.json
  def create
    @gas_grade = GasGrade.new(gas_grade_params)

    respond_to do |format|
      if @gas_grade.save
        format.html { redirect_to @gas_grade, notice: 'Gas grade was successfully created.' }
        format.json { render :show, status: :created, location: @gas_grade }
      else
        format.html { render :new }
        format.json { render json: @gas_grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gas_grades/1
  # PATCH/PUT /gas_grades/1.json
  def update
    respond_to do |format|
      if @gas_grade.update(gas_grade_params)
        format.html { redirect_to @gas_grade, notice: 'Gas grade was successfully updated.' }
        format.json { render :show, status: :ok, location: @gas_grade }
      else
        format.html { render :edit }
        format.json { render json: @gas_grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gas_grades/1
  # DELETE /gas_grades/1.json
  def destroy
    @gas_grade.destroy
    respond_to do |format|
      format.html { redirect_to gas_grades_url, notice: 'Gas grade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gas_grade
      @gas_grade = GasGrade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gas_grade_params
      params[:gas_grade]
    end
end
