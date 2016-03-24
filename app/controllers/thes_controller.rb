class ThesController < ApplicationController
  before_action :set_the, only: [:show, :edit, :update, :destroy]

  # GET /thes
  # GET /thes.json
  def index
    @thes = The.page(params[:page])
  end

  # GET /thes/1
  # GET /thes/1.json
  def show
  end

  # GET /thes/new
  def new
    @the = The.new
  end

  # GET /thes/1/edit
  def edit
  end

  # POST /thes
  # POST /thes.json
  def create
    @the = The.new(the_params)

    respond_to do |format|
      if @the.save
        format.html { redirect_to @the, notice: 'The was successfully created.' }
        format.json { render :show, status: :created, location: @the }
      else
        format.html { render :new }
        format.json { render json: @the.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /thes/1
  # PATCH/PUT /thes/1.json
  def update
    respond_to do |format|
      if @the.update(the_params)
        format.html { redirect_to @the, notice: 'The was successfully updated.' }
        format.json { render :show, status: :ok, location: @the }
      else
        format.html { render :edit }
        format.json { render json: @the.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /thes/1
  # DELETE /thes/1.json
  def destroy
    @the.destroy
    respond_to do |format|
      format.html { redirect_to thes_url, notice: 'The was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_the
      @the = The.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def the_params
      params.require(:the).permit(:name,:department)
    end
end
