class HowToController < ApplicationController
  def show
    @section = params[:itemId] || "1"
  end
end
