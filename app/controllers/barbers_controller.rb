class BarbersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_barber, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  # GET /barbers or /barbers.json
  def index
    @barbers = Barber.all
  end

  # GET /barbers/1 or /barbers/1.json
  def show
    @schedule = Barber.schedule
    @free_days = Turn.weekends_off_modded(params[:id])
    @occupied_today = Barber.today_busy(params[:id])
    @occupied_tomorrow = Barber.tomorrow_busy(params[:id])
    @occupied_after = Barber.after_busy(params[:id])

    puts "ACA VA HOY FECHA", Time.now.strftime("%H:%M")
    puts "ACA VA EL ID", params[:id]
    puts "ACA VA FREE", @free_days
    puts "ACA VA HOY", @occupied_today
    puts "ACA VA MAÑANA", @occupied_tomorrow
    puts "ACA VA PASADO", @occupied_after
  end

  def free
    @barber = Barber.find_by_id(params[:id])
  end

  # GET /barbers/new
  def new
    @barber = Barber.new
    @services = Service.all
  end

  # GET /barbers/1/edit
  def edit
    @services = @barber.services
  end

  # POST /barbers or /barbers.json
  def create
    @barber = Barber.new(barber_params)

    respond_to do |format|
      if @barber.save
        format.html { redirect_to @barber, notice: "Barber was successfully created." }
        format.json { render :show, status: :created, location: @barber }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @barber.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /barbers/1 or /barbers/1.json
  def update
    respond_to do |format|
      if @barber.update(barber_params)
        format.html { redirect_to barbers_path }
        format.json { render :index, status: :ok, location: @barber }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @barber.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /barbers/1 or /barbers/1.json
  def destroy
    exist = @barber.validate_turns(@barber)
    if exist == 0
      for i in HasBarber.all
        if i.barber_id == @barber.id
          i.destroy
        end
      end

      for i in Turn.all
        if i.barber_id == @barber.id
          i.destroy
        end
      end

      @barber.destroy
      respond_to do |format|
        format.html { redirect_to barbers_url, notice: "Barber was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to barbers_url, notice: "El barbero no puede ser destruido debido a que tiene turnos pendientes" }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_barber
      @barber = Barber.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def barber_params
      params.require(:barber).permit(:first_name, :last_name, :description, service_ids:[])
    end
end
