class GiftSuggestionsController < ApplicationController
  before_action :authenticate_user!


  def new
    @contens = nil
  end

  def create
    
  end
end
