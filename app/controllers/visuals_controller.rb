class VisualsController < ApplicationController

  before_action :only_admin, only: [:new, :create, :destroy, :edit, :update]

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

  def destroy
    @visual = Visual.find(params[:id])
    @visual.destroy
    redirect_to visuals_path
  end

  def edit
    @visual = Visual.find(params[:id])
  end

  def update
    @visual = Visual.find(params[:id])
    if @visual.valid?
      @visual.update(visual_params)
      redirect_to visuals_path
    else
      redirect_to edit_visual(params[:id])
    end
  end

  private

  def visual_params
    params.require(:visual).permit(:image).merge(user_id: current_user.id)
  end

  def only_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end
end
