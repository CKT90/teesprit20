class UsersController < ApplicationController
	before_action :logged_in_user, only: [:index, :edit, :update, :destroy] #without logging in, user cannot access 'edit' via URL
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_user, only: :destroy
  
	def index
	  	@users = User.paginate(page: params[:page])
	end

	def show
	  	@user = User.find(params[:id]) 
	end

	def new
	  	if logged_in?
	  		redirect_to root_url
	  	else
	  		@user = User.new
	  	end
	end

	def create
	  	if logged_in?
	  		redirect_to root_url
	  	else
			@user = User.new(user_params)
			  if @user.save
			  	@user.send_activation_email
			  	UserMailer.notify_admin(@user).deliver_now
			  	@user.send_empty_email
				flash[:info] = "Please check your email to activate your account."
				redirect_to store_url
			  else
			  	render 'new'
		  	end
		end
	end

	def update
	  	@user = User.find(params[:id])
	  	if @user.update(user_params)
	  	   flash[:success] = "Profile updated"
		   redirect_back fallback_location: orders_path
	  	else
	  	   flash[:danger] = "Name can't be empty. / Contact Number only accept number characters." 
	  	   redirect_back fallback_location: orders_path
	  	end
	end

	def resend_validation
	end

    def resend_validation_action
		@user = User.find_by(email: params[:account][:email].downcase)

		if @user == nil 
			flash[:info] = "Unauthorized"
			redirect_to store_url
		else
			if @user && @user.activated?
				flash[:success] = "Unauthorized Activation, please contact admin"
				redirect_to store_url
			else
				@user.update(:activation_digest => nil)
				@user.create_activation_digest
				@user.save!
				UserMailer.account_activation(@user).deliver_now
				flash[:info] = "Please check your email to activate your account."
				redirect_to store_url
			end
		end
	end

	private

 	def user_params
		params.require(:user).permit(:name, :email, :contact_number, :address, :password, :password_confirmation)
 	 end

	def logged_in_user 
		unless logged_in?
			store_location
			flash[:danger] = "Please log in."
			redirect_to login_url
		end
	end

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_url) unless current_user?(@user)
	end

	def admin_user
		redirect_to(root_url) unless current_user.admin?
	end

end
