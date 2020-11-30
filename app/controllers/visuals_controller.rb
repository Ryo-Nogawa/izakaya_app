class VisualsController < ApplicationController

  def index
    @visuals = Visual.all
  end

  def new
    @visual = Visual.new
  end

  def create
    visual = Visual.new(visual_params)
    if visual.valid?
      visual.save
      redirect_to visuals_path
    else
      render :new
    end
  end

  def show
    @visual = Visual.find(params[:id])
  end

  def 

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def visual_params
    params.require(:visual).permit(:image).merge(user_id: current_user.id)
  end
end
