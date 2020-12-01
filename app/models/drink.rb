class Drink < ApplicationRecord

  def index
    @drinks = Drink.all
  end
  
end
