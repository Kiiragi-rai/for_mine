class PartnersController < ApplicationController
    before_action :authenticate_user!
#has one はpartner s付かない
    def show
        @partner = current_user.partner
    end
#  newとcreate だと入らなかった
    def new 
        @partner = current_user.build_partner
    end
    def create
        @partner = current_user.build_partner(partner_params)
        if @partner.save
            redirect_to partner_path, success: "大切な人を見つけました"
        else
            flash.now[:danger] = "登録に失敗しました。再度入力していください"
            render :new, status: :unprocessable_content
        end
    end

    def edit
        @partner = current_user.partner
    end

    def update
        @partner = current_user.partner
        p @partner
        if @partner.update(partner_params)
            redirect_to partner_path,success: "更新に成功しました"
        else
            flash.now[:danger] = "更新に失敗しました。再度入力してください"
            render :edit, status: :unprocessable_content
        end

    end

    
        def destroy
            partner = current_user.partner
            partner.destroy!
            redirect_to root_path, success: "削除しました"
        end
    



    private

    # モデルに移動にする？
    def partner_params
        params.require(:partner).permit(:name, :sex, :age,:relation, :job,:favorites, :avoidances,:hobbies,
        :budget_min,:budget_max)
    end 
end



