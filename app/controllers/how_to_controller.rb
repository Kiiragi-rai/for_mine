class HowToController < ApplicationController
  def show
    @section = params[:itemId] || "1"
    set_meta_tags(
      title: "使い方"
    )
  end
end
