class MyPagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    set_meta_tags(
      title: "マイページ"
    )
  end

  def confirm
    set_meta_tags(
      title: "退会確認"
    )
  end

  def withdraw
    # 論理削除する場合は調整必要　カラム消す可能性もあり
    # current_user.update!(is_deleted: true, uid: nil)
    current_user.destroy!

    reset_session
    redirect_to root_path, notice: "これまで使ってくれてありがとう😊またいつでも戻ってきてね", status: :see_other
  end
end
