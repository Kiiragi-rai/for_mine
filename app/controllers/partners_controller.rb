class PartnersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_partner, only: %i[show edit update destroy]

    # has one はpartner s付かない
    def show
        @partnercount = @partner&.change_to_progress_bar_value if @partner.present?
        set_meta_tags(
            title: "パートナー詳細"
          )
    end
    #  newとcreate だと入らなかった
    def new
        @partner = current_user.build_partner
        set_meta_tags(
            title: "パートナー作成"
          )
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
        set_meta_tags(
            title: "パートナー編集"
          )
    end

    def update
        if @partner.update(partner_params)
            redirect_to partner_path, success: "更新に成功しました"
        else
            flash.now[:danger] = "更新に失敗しました。再度入力してください"
            render :edit, status: :unprocessable_content
        end
    end


        def destroy
            @partner.destroy!
            redirect_to root_path, success: "削除しました"
        end




    private
    def set_partner
        @partner = current_user.partner
      end
    

    def partner_params
        params.require(:partner).permit(:name, :sex, :age, :relation, :job, :favorites, :avoidances, :hobbies,
        :budget_min, :budget_max)
    end
end
