class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    params[:micropost].except(:content).each do |key, value|
      if value == '1'
        @micropost.ingredients << Ingredient.find_by(name: "#{key}")
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
      params.require(:micropost).permit(:content, :picture, Ingredient.all.collect{|x| x.name})
    end
end