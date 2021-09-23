class PrototypesController < ApplicationController
  def index
    @prototypes = Prototype.includes(:prototype)
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
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    prototype = prototype.find(params[:id])
    prototype.update(prototype_params)
    if prototype.save
      redirect_to root_path(@prototype)
    else
      @prototype = @user.prototype.includes(:user)
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