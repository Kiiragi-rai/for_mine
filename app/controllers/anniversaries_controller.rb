class AnniversariesController < ApplicationController
    before_action :authenticate_user!

    def index
        @anniversaries = current_user.anniversaries
    end

    def show
        @anniversary = current_user.anniversaries.find_by_hashid(params[:id])
    end


    def new
        Rails.logger.debug params.to_unsafe_h
        @anniversary = current_user.anniversaries.build
        @form = AnniversaryNotificationSettingForm.new(user: current_user, anniversary: @anniversary)
      end

    def create
        Rails.logger.debug params.to_unsafe_h
        @anniversary = current_user.anniversaries.build
        @form = AnniversaryNotificationSettingForm.new(
          user: current_user,
          anniversary: @anniversary,
          **anniversary_notification_setting_params
        )
        p [params.dig(:anniversary_notification_setting_form, :frequency_days),
        @form.frequency_days,
        @form.frequency_days.class]
        if @form.save
          redirect_to anniversaries_path, notice: "記念日を登録しました"
        else
          render :new, status: :unprocessable_entity
        end
    end


    def edit
        @anniversary = current_user.anniversaries.find_by_hashid(params[:id])
        @form = AnniversaryNotificationSettingForm.new(
            user: current_user,
            anniversary: @anniversary
          )
    end

    def update
        @anniversary = current_user.anniversaries.find_by_hashid(params[:id])
        @form = AnniversaryNotificationSettingForm.new(
            user: current_user,
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

#  id                :bigint           not null, primary key
#  frequency_days    :integer          default(1), not null
#  is_enabled        :boolean          default(FALSE), not null
#  last_sent_on      :date
#  notification_time :time
#  start_on          :date
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  anniversary_id    :bigint           not null
#
# Indexes