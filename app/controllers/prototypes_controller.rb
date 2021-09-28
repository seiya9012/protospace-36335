class PrototypesController < ApplicationController
  #CSRF保護を無効にする
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create

    @prototype = Prototype.new(prototype_params)

    if @prototype.save
      redirect_to root_path(@prototype)
    else
      render :new
      @prototype = Prototype.includes(:user)
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless @prototype.user_id == current_user.id
      redirect_to prototypes_path
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    @prototype.update(prototype_params)
    if @prototype.save
      redirect_to action: "show"
    else
      
      render :edit
    end
  end

   def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
   end

   private
   def prototype_params
    params[:prototype].permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
   end



   def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
