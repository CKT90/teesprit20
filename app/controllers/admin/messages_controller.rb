class Admin::MessagesController < Admin::BaseController

	def index
		@search = Message.search(params[:q])
    	@messages = @search.result.order('updated_at DESC')
	end

	def show
	end

	def edit
	end

	def update
	end


	private

 	 def message_params
		params.require(:message).permit(:sender_email, :subject, :content)
 	 end


end
