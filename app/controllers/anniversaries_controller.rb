class AnniversariesController < ApplicationController
    before_action :authenticate_user!

    def index
        @anniversaries = current_user.anniversaries
    end

    def show
        @anniversary = current_user.anniversaries.find(params[:id])
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
        render :new, status: :unprocessable_content
        end
    end

    def edit
        @anniversary = current_user.anniversaries.find(params[:id])
    end

    def update
        @anniversary = current_user.anniversaries.find(params[:id])
        p @anniversary
        if @anniversary.update(anniversary_params)
            redirect_to anniversaries_path,success: "suceess"
        else
            flash.now[:danger] = "danger"
            render :edit, status: :unprocessable_content
        end
    end
    def destroy
        anniversary = current_user.anniversaries.find(params[:id])
        anniversary.destroy!
        redirect_to anniversaries_path, success: "success"
    end



    private 
    def anniversary_params
        params.require(:anniversary).permit(:title, :anniversary_date)
    end
end
