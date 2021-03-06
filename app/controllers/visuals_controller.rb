# frozen_string_literal: true

class VisualsController < ApplicationController
  before_action :only_admin, only: %i[new create destroy edit update]

  before_action :search_product, only: %i[index search]

  def index
    @visuals = Visual.all.order(visual_category_id: :ASC)
  end

  def search
    @results = @p.result.all
  end

  def new
    @visual = Visual.new
  end

  def create
    @visual = Visual.new(visual_params)
    if @visual.valid?
      @visual.save
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
  end

  def edit
    @visual = Visual.find(params[:id])
  end

  def update
    @visual = Visual.find(params[:id])
    if @visual.update(visual_params)
    else
      redirect_to edit_visual(params[:id])
    end
  end

  private

  def visual_params
    params.require(:visual).permit(:image, :visual_category_id).merge(user_id: current_user.id)
  end

  def only_admin
    redirect_to root_path unless current_user.admin?
  end

  def search_product
    @p = Visual.ransack(params[:q])
  end
end
