class Admin::ImagesController < Admin::BaseController

	def destroy
		@image = Image.find_by(id: params[:id])
		@product = Product.find_by(number: params[:product_id])
		Image.find(params[:id]).destroy
	  
	    respond_to do |format|
	    	format.html { redirect_to edit_admin_product_url(@product)
	                      flash[:success] = "Image deleted" }
	    	format.js { render layout: false }
	  	end	
	end

end

