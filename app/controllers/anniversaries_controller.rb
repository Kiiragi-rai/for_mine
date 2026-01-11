class AnniversariesController < ApplicationController
    before_action :authenticate_user!

    def index
        @anniversaries = current_user.anniversaries
    

    end

    def show
        @anniversary = current_user.anniversaries.find_by_hashid(params[:id])
    end

    def new 
        @anniversary = Anniversary.new
    end

    def create 
        @anniversary = current_user.anniversaries.build(anniversary_params)
        if @anniversary.save 
            redirect_to anniversaries_path ,success: '記念日を登録しました'
        else
        flash.now[:danger] = '記念日登録に失敗しました。再度入力して下さい' 
        render :new, status: :unprocessable_content
        end
    end

    def edit
        @anniversary = current_user.anniversaries.find_by_hashid(params[:id])
    end

    def update
        @anniversary = current_user.anniversaries.find_by_hashid(params[:id])
        p @anniversary
        if @anniversary.update(anniversary_params)
            redirect_to anniversaries_path,success: "記念日を更新しました"
        else
            flash.now[:danger] = "記念日更新に失敗しました"
            render :edit, status: :unprocessable_content
        end
    end
    def destroy
        anniversary = current_user.anniversaries.find_by_hashid(params[:id])
        anniversary.destroy!
        redirect_to anniversaries_path, success: "記念日を削除しました"
    end



    private 
    def anniversary_params
        params.require(:anniversary).permit(:title, :anniversary_date,:notification_on)
    end
end
