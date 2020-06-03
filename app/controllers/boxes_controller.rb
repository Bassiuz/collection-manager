class BoxesController < ApplicationController
  before_action :set_box, only: [:show, :edit, :update, :destroy]
  before_action :set_cards, only: [:show, :edit]

  # GET /boxes
  # GET /boxes.json
  def index
    @storage_boxes = current_user.boxes.where(box_type: "Storage Box")
    @deck_boxes = current_user.boxes.where(box_type: "Deckbox")
    @trade_binders = current_user.boxes.where(box_type: "Tradebinder")
  end

  # GET /boxes/new
  def new
    @box = Box.new
  end
  
  # POST /boxes
  # POST /boxes.json
  def create
    @box = Box.new(box_params)

    respond_to do |format|
      if @box.save
        format.html { redirect_to @box, notice: 'Box was successfully created.' }
        format.json { render :show, status: :created, location: @box }
      else
        format.html { render :new }
        format.json { render json: @box.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boxes/1
  # PATCH/PUT /boxes/1.json
  def update
    respond_to do |format|
      if @box.update(box_params)
        format.html { redirect_to @box, notice: 'Box was successfully updated.' }
        format.json { render :show, status: :ok, location: @box }
      else
        format.html { render :edit }
        format.json { render json: @box.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boxes/1
  # DELETE /boxes/1.json
  def destroy
    @box.destroy
    respond_to do |format|
      format.html { redirect_to boxes_url, notice: 'Box was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_box
      @box = Box.find(params[:id])
    end

    def set_cards
      @cards = @box.cards.all
    end

    # Only allow a list of trusted parameters through.
    def box_params
      params.require(:box).permit(:name, :size, :leave_box_in_tact, :box_type, :deckname).merge(user: current_user)
    end
end
