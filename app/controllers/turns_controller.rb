class TurnsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_turn, only: %i[ show edit update destroy ]
  skip_forgery_protection
  load_and_authorize_resource

  # GET /turns or /turns.json
  #Se agrego verificacion de t.time para cargar el index sin errores
  def index
    Turn.clean()
    
    if params[:from] && params[:to]
      if params[:from].blank? && params[:to].blank?
        @turns = Turn.all
      elsif params[:from].blank?
        redirect_to turns_path, :notice => "La fecha 'Desde' no puede estar en blanco"
      elsif params[:to].blank?
        redirect_to turns_path, :notice => "La fecha 'Hasta' no puede estar en blanco"
      elsif params[:from] >= params[:to]
        redirect_to turns_path, :notice => "La fecha 'Desde' debe ser anterior a la fecha 'Hasta'"
      else
        @turns = Turn.find_by_range(params[:from], params[:to])
      end
    elsif params[:client]
      @turns = Turn.find_by_client(params[:client])
    elsif params[:selecteday]
      @turns = Turn.find_by_day(params[:selecteday])
    else
      @turns = Turn.all.where(:p == 1)
    end
    @turns = @turns.where(p: 1, edit: 0)
    @turns = @turns.sort_by(&:time)
      
  end

  # GET /turns/1 or /turns/1.json
  def show
    @turn = Turn.find(params[:id])
  end

  # GET /turns/new
  def new
    @turn = Turn.new
    @services = Service.all
    @days = Turn.selectable_dates
  end

  def edit0
    @days = Turn.selectable_dates
    @turn = Turn.find(params[:id])
    #@weekends = Turn.weekends_off(params[:id])
    @barbers = Barber.all
  end

  # GET /turns/1/edit
  def edit
    @days = Turn.selectable_dates
    @weekends = Turn.weekends_off(params[:barber_id])
    @services = @turn.services
  end

  def edit2
    @times = Turn.selectable_times(params[:id])
    @occupied = Turn.work_or_free(params[:id])
  end
  

  # POST /turns or /turns.json
  def create
    @turn = Turn.new(turn_params)

    respond_to do |format|
      if @turn.save
        if @turn.edit.blank?
          format.html { redirect_to edit0_url(:id => @turn) }
        else
          format.html { redirect_to edit2_url(:id => @turn) }
        end
        format.json { render :show, status: :created, location: @turn }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @turn.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /turns/1 or /turns/1.json
  def update
    respond_to do |format|
      if @turn.edit == 2
        @turn.edit = 0
        @turn.p = 1

        puts "LOS PARAMS PADREEE", turn_params

        if @turn.update(turn_params)
          format.html { redirect_to @turn }
          format.json { render :show, status: :ok, location: @turn }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @turn.errors, status: :unprocessable_entity }
        end
      else
        if @turn.update(turn_params)
          format.html { redirect_to edit2_url(:id => @turn) }
          format.json { render :show, status: :ok, location: @turn }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @turn.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /turns/1 or /turns/1.json
  def destroy
    for i in HasTurn.all
      if i.turn_id == @turn.id
        i.destroy
      end
    end
    @turn.destroy
    respond_to do |format|
      format.html { redirect_to turns_url, notice: "Turn was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_turn
      @turn = Turn.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def turn_params
      params.require(:turn).permit(:time, :client, :edit, :p, :barber_id, service_ids:[])
    end
end