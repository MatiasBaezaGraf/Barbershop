class HolidaysController < ApplicationController
  before_action :set_holiday, only: %i[ show edit update destroy ]

  # GET /holidays or /holidays.json
  def index
    #Eliminar dia libre luego de que pasaron 2 semanas
    for h in Holiday.all
      if h.freeday < (Date.today - 15.day) and h.permanent == 0
        h.destroy
      end
    end

    if params[:barber_id]
      @holidays = Holiday.all.where(:barber_id => params[:barber_id])
      @holidays = @holidays.sort_by(&:freeday)
    else
      @holidays = []
    end
  end

  # GET /holidays/1 or /holidays/1.json
  def show
  end

  # GET /holidays/new
  def new
    @holiday = Holiday.new
    @weekdays = [Date.new(2021, 05, 24), Date.new(2021, 05, 25), Date.new(2021, 05, 26), Date.new(2021, 05, 27), Date.new(2021, 05, 28), Date.new(2021, 05, 29), Date.new(2021, 05, 30)]
  end

  # GET /holidays/1/edit
  def edit
    @weekdays = [Date.new(2021, 05, 24), Date.new(2021, 05, 25), Date.new(2021, 05, 26), Date.new(2021, 05, 27), Date.new(2021, 05, 28), Date.new(2021, 05, 29), Date.new(2021, 05, 30)]
  end

  # POST /holidays or /holidays.json
  def create
    @holiday = Holiday.new(holiday_params)

    respond_to do |format|
      if @holiday.save
        format.html { redirect_to @holiday, notice: "Holiday was successfully created." }
        format.json { render :show, status: :created, location: @holiday }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @holiday.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /holidays/1 or /holidays/1.json
  def update
    respond_to do |format|
      if @holiday.update(holiday_params)
        format.html { redirect_to @holiday, notice: "Holiday was successfully updated." }
        format.json { render :show, status: :ok, location: @holiday }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @holiday.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /holidays/1 or /holidays/1.json
  def destroy
    @holiday.destroy
    respond_to do |format|
      format.html { redirect_to holidays_url, notice: "Holiday was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_holiday
      @holiday = Holiday.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def holiday_params
      params.require(:holiday).permit(:freeday, :permanent, :barber_id)
    end
end
