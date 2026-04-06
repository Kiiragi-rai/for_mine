class AnniversariesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_anniversary, only: [ :show, :edit, :update, :destroy ]

    def index
        @q = current_user.anniversaries.ransack(params[:q])
        @anniversaries = @q.result.includes(:notification_setting).page(params[:page]).per(10)
        set_meta_tags(
          title: "記念日一覧"
        )
    end

    def calendar
      @anniversaries = current_user.anniversaries
      set_meta_tags(
        title: "記念日カレンダー"
      )
    end

    def show
      set_meta_tags(
        title: "記念日詳細"
      )
    end


    def new
        @anniversary = current_user.anniversaries.build
        @form = AnniversaryNotificationSettingForm.new(anniversary: @anniversary)
        set_meta_tags(
          title: "記念日作成"
        )
        # ここに１００日後、
      end

    def create
        @anniversary = current_user.anniversaries.build
        @form = AnniversaryNotificationSettingForm.new(
          # user: current_user,
          anniversary: @anniversary,
          **anniversary_notification_setting_params
        )
        if @form.save
          redirect_to anniversaries_path, notice: "記念日を登録したよ😊これで忘れずに大切にできるね"
        else
          render :new, status: :unprocessable_entity
        end
    end


    def edit
        @form = AnniversaryNotificationSettingForm.new(
            # user: current_user.,
            anniversary: @anniversary
          )
          set_meta_tags(
            title: "記念日編集"
          )
    end

    def update
        Rails.logger.debug params[:anniversary_notification_setting_form].inspect
        @form = AnniversaryNotificationSettingForm.new(
            # user: current_user,
            anniversary: @anniversary,
            **anniversary_notification_setting_params
          )
        if @form.save
            redirect_to anniversaries_path, notice: "記念日を更新したよ✨より良い形になったね"
        else
            flash.now[:danger] = "うまく更新できなかったみたい…もう一度だけ確認してみよう🙏"
            render :edit, status: :unprocessable_content
        end
    end
    def destroy
        @anniversary.destroy!
        redirect_to anniversaries_path, notice: "記念日を削除したよ😊また必要になったら、いつでも追加できるよ"
    end



    private

    def set_anniversary
      @anniversary = current_user.anniversaries.find_by_hashid!(params[:id])
    end

    def anniversary_notification_setting_params
        params.require(:anniversary_notification_setting_form).permit(:title, :anniversary_date, :is_enabled, :frequency_days,
        :notification_hour, :start_on)
    end
end
