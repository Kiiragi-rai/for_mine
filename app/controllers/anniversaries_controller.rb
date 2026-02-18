class AnniversariesController < ApplicationController
    before_action :authenticate_user!

    def index
        @anniversaries = current_user.anniversaries
    end

    def calendar
      @anniversaries = current_user.anniversaries
    end

    def show
        @anniversary = current_user.anniversaries.find_by_hashid(params[:id])
    end


    def new
        @anniversary = current_user.anniversaries.build
        @form = AnniversaryNotificationSettingForm.new(anniversary: @anniversary)
      end

    def create
        @anniversary = current_user.anniversaries.build
        @form = AnniversaryNotificationSettingForm.new(
          # user: current_user,
          anniversary: @anniversary,
          **anniversary_notification_setting_params
        )
        if @form.save
          redirect_to anniversaries_path, notice: "記念日を登録しました"
        else
          render :new, status: :unprocessable_entity
        end
    end


    def edit
        @anniversary = current_user.anniversaries.find_by_hashid(params[:id])
        @form = AnniversaryNotificationSettingForm.new(
            # user: current_user,
            anniversary: @anniversary
          )
    end

    def update
        @anniversary = current_user.anniversaries.find_by_hashid(params[:id])
        Rails.logger.debug params[:anniversary_notification_setting_form].inspect
        @form = AnniversaryNotificationSettingForm.new(
            # user: current_user,
            anniversary: @anniversary,
            **anniversary_notification_setting_params
          )
        if @form.save
            redirect_to anniversaries_path, success: "記念日を更新しました"
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


    def anniversary_notification_setting_params
        params.require(:anniversary_notification_setting_form).permit(:title, :anniversary_date, :is_enabled, :frequency_days,
        :notification_time, :start_on)
    end
end
