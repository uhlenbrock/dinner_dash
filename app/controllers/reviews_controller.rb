class ReviewsController < ApplicationController
  before_action :set_item
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :authorized_for_user?, only: [:edit, :update, :destroy]

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = @item.reviews.all
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = @item.reviews.build
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = @item.reviews.build(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to @item, notice: 'Review was successfully created.' }
        format.json { render action: 'show', status: :created, location: @review }
      else
        format.html { render action: 'new' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @item, notice: 'Review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to @item }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = @item.reviews.find(params[:id])
    end

    def set_item
      @item = Item.find(params[:item_id])
    end
  
    def authorized_for_user?
      redirect_to root_path, alert: 'Not authorized!' unless user_signed_in? && (current_user.id == @review.user_id)
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params[:review].permit!
    end
end
