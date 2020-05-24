class StoreController < ApplicationController

  def index
  	@products = Product.all.where(state_cd: 1).where(hidden: false).paginate(:page => params[:page], :per_page => 9).order('created_at DESC') # 'order' is to make item list orderly
  	
  end
end
