class TurnsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_turn, only: %i[ show edit update destroy ]
  skip_forgery_protection
  load_and_authorize_resource

  # GET /turns or /turns.json
  def index
    for t in Turn.all
      if t.p != 1
        for i in HasTurn.all
          if i.turn_id == t.id
            i.destroy
          end
        end

        t.destroy
      end
    end

    @turns = Turn.all
  end

  # GET /turns/1 or /turns/1.json
  def show
  end

  # GET /turns/new
  def new
    @turn = Turn.new
    @services = Service.all
  end

  def edit0
    @days = Turn.selectable_dates
    @weekends = Turn.weekends_off
    @barbers = Barber.all
  end

  # GET /turns/1/edit
  def edit
    @days = Turn.selectable_dates
    @weekends = Turn.weekends_off
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
          format.html { redirect_to edit0_url(:id => @turn), notice: "Turn was successfully created." }
        else
          format.html { redirect_to edit2_url(:id => @turn), notice: "Turn was successfully created." }
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
      puts @turn.edit
      if @turn.edit == 1
        @turn.edit = 0
        @turn.p = 1
        if @turn.update(turn_params)
          format.html { redirect_to @turn, notice: "Turn was successfully updated." }
          format.json { render :show, status: :ok, location: @turn }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @turn.errors, status: :unprocessable_entity }
        end
      else
        if @turn.update(turn_params)
          format.html { redirect_to edit2_url(:id => @turn), notice: "Turn was successfully updated." }
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
