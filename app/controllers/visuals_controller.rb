class VisualsController < ApplicationController

  def index
    @visuals = Visuals.all
  end
end
