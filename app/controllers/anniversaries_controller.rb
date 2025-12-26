class AnniversariesController < ApplicationController
    before_action :authenticate_user!

    def index
        @anniversaries = current_user.anniversaries
    end

    def new 
        @anniversary = Anniversary.new
    end

    def create 
        @anniversary = current_user.anniversaries.build(anniversary_params)
        if @anniversary.save 
            redirect_to anniversaries_path ,success: 'good'
        else
        flash.now[:danger] = 'failure try again' 
        render :new, status: :unprocessable_entity
        end
    end



    private 
    def anniversary_params
        params.require(:anniversary).permit(:title, :anniversary_date)
    end
end
