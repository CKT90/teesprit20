class Admin::OptionTypesController < Admin::BaseController

	def index

    @option_type = OptionType.new

		@search = OptionType.ransack(params[:q]) 
    @option_types = @search.result
	
  end

	def edit 
		@option_type = OptionType.find(params[:id])
		@option_type.option_values.build if @option_type.option_values.empty?

	end

	def create
	  @option_type = OptionType.new(option_type_params)
      if @option_type.save
        flash[:success] = "New option type created!"
        redirect_to admin_option_types_path
      else
        redirect_to admin_option_types_path, :flash => {:danger =>  @option_type.errors.full_messages.join("\n") }
      end
    end

  def update 
  	@option_type = OptionType.find(params[:id])
  	if @option_type.update(option_type_attr_params)
      flash[:success]= "Option type updated!"
       redirect_to edit_admin_option_type_path(@option_type)
    else
      flash[:danger]= "error!"
      redirect_to edit_admin_option_type_path(@option_type), :flash => {:danger =>  @option_type.errors.full_messages.join("\n") }
    end
  end

  def update_options_positions
    params[:entry].each_with_index do |id, index|
      OptionType.where(id: id).update_all(position: index + 1)
    end
    head :ok
  end


  def update_values_positions
    params[:entry].each_with_index do |id, index|
      OptionValue.where(id: id).update_all(position: index + 1)
    end
    head :ok
  end


private

  def option_type_params
    params.require(:option_type).permit(:name, :presentation, :color)
    #params.require(:product).permit(:SKU, :price, :count_on_hand, :cost_price)
  end

	def option_type_attr_params 
 	  params.require(:option_type).permit(:position, :name, :presentation, :hidden, option_values_attributes: [:id, :name, :presentation, :hidden, :_destroy])
  end
end

