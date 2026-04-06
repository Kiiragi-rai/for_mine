class PartnersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_partner, only: %i[show edit update destroy]


    def show
        @partnercount = @partner&.change_to_progress_bar_value if @partner.present?
        set_meta_tags(
            title: "パートナー詳細"
          )
    end
  
    def new
        @partner = current_user.build_partner
        set_meta_tags(
            title: "パートナー作成"
          )
    end

    def create
        @partner = current_user.build_partner(partner_params)
        if @partner.save
            redirect_to partner_path, notice: "大切な人を登録したよ😊これで、もっと想いを形にできるね"
        else
            flash.now[:danger] = "うまく登録できなかったみたい…もう一度ゆっくり確認してみよう🙏"
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
            redirect_to partner_path, notice: "パートナー情報を更新したよ✨\nよりぴったりな提案ができそうだね"
        else
            flash.now[:danger] = "更新できなかったみたい…入力内容をもう一度確認してみよう🙏"
            render :edit, status: :unprocessable_content
        end
    end


        def destroy
            @partner.destroy!
            redirect_to root_path, notice: "パートナー情報を削除したよ😊またいつでも登録できるから安心してね😊"
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
