class Admin::UsersController < Admin::BaseController
  
  def index
    @search = User.search(params[:q])
    @users = @search.result.paginate(:page => params[:page], :per_page => 10).order('updated_at DESC')
  end

  def show
  	@user = User.find(params[:id]) 
  end

  def edit
    @user = User.find(params[:id]) 
    @search = @user.orders.search(params[:q])
    @orders = @search.result.order('updated_at DESC')
  end

  def new
  	@user = User.new
  end

  def create
  	if @user.save
  		flash[:info] = "Account created!"
  		redirect_to store_url
  	else
	  	render 'new'
  	end
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  	   flash[:success] = "Profile updated"
	   redirect_to :back
  	else
  	   flash[:danger] = "Name can't be empty. / Contact Number only accept number characters." 
  	   redirect_to :back
  	end
  end

  def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User deleted"
		redirect_to users_url
	end
  
  private

 	 def user_params
		params.require(:user).permit(:name, :email, :contact_number, :address, :password, :password_confirmation)
 	 end

	# Before filters
	# Confirms a logged-in user.
	def logged_in_user #used above, for before_action
		unless logged_in?
			store_location
			flash[:danger] = "Please log in."
			redirect_to login_url
		end
	end


	def admin_user
		redirect_to(root_url) unless current_user.admin?
	end

end
