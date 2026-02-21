class HowToController < ApplicationController
  def show
    @section = params[item:ID] || "1"
  end
end
