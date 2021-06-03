class FreetimesController < ApplicationController
  before_action :set_freetime, only: %i[ show edit update destroy ]

  # GET /freetimes or /freetimes.json
  def index
    @freetimes = Freetime.all
    @freetimes = @freetimes.sort_by(&:permanent)
  end

  # GET /freetimes/1 or /freetimes/1.json
  def show
  end

  # GET /freetimes/new
  def new
    @freetime = Freetime.new

    @barbers = Barber.all
  end

  # GET /freetimes/1/edit
  def edit
  end

  # POST /freetimes or /freetimes.json
  def create
    @freetime = Freetime.new(freetime_params)

    respond_to do |format|
      if @freetime.save
        format.html { redirect_to @freetime, notice: "Freetime was successfully created." }
        format.json { render :show, status: :created, location: @freetime }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @freetime.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /freetimes/1 or /freetimes/1.json
  def update
    respond_to do |format|
      if @freetime.update(freetime_params)
        format.html { redirect_to @freetime, notice: "Freetime was successfully updated." }
        format.json { render :show, status: :ok, location: @freetime }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @freetime.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /freetimes/1 or /freetimes/1.json
  def destroy
    @freetime.destroy
    respond_to do |format|
      format.html { redirect_to freetimes_url, notice: "Freetime was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_freetime
      @freetime = Freetime.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def freetime_params
      params.require(:freetime).permit(:from, :to, :permanent, :barber_id)
    end
end
