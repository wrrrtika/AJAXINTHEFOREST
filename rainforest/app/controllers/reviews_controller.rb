class ReviewsController < ApplicationController
  before_filter :load_product
  # , :ensure_logged_in, only: [:create, :destroy]
  

  def show
  	@review = Review.find(params[:id])
  end

  def create
  	@review = @product.reviews.build(review_params)
  	@review.user = current_user

  	# if @review.save
  	# 	redirect_to products_path, notice: 'Review Created.'
  	# else
  	# 	render 'products/show'
  	# end
    respond_to do |format|
      if @review.save
        format.html { redirect_to product_path (@product.id), notice: 'Review Created.'}
        format.js {}
      else
        format.html { render 'products/show', alert: 'There was an error!'}
        format.js {}
      end
    end
  end

  def destroy
  	@review = Review.find(params[:id])
  	@review.destroy
  end

  private

  def review_params
  	params.require(:review).permit(:comment, :product_id)
  end

  def load_product
  	@product = Product.find(params[:product_id])
  end

end
