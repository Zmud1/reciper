class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.ingredient_quantities.each.collect do |i|
      if i.quantity == 0
        i.delete
      end 
    end 
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end
  
  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end
   
  private
  
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end


    def micropost_params
      params.require(:micropost).permit(:content, :picture, {ingredient_ids: []}, ingredient_quantities_attributes: [:micropost_id, :ingredient_id, :quantity, :measure]) #This is for the unoptimal method, Ingredient.all.collect{|x| x.name})
    end
    
end